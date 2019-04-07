# -*- coding: utf-8 -*-

from pymongo import MongoClient

mongo = MongoClient('localhost', 27017).sssm

# Migrate sessions
sessions = mongo.sessions.find({'username': None})
for session in sessions:
    user = mongo.users.find_one({'_id': session['user_id']})

    if user is not None:
        mongo.sessions.update_one({'_id': session['_id']},
                                  {'$set': {
                                      'username': user['username']
                                  }})
    else:
        print('Error updating session ' + str(session['_id']))
        print('User ' + str(session['user_id']))

# Migrate reports
reports = mongo.reports.find({'username': None, 'token': None})
for report in reports:
    server = mongo.servers.find_one({'_id': report['server_id']})

    if server is not None:
        user = mongo.users.find_one({'_id': server['user_id']})
        mongo.reports.update_one({'_id': report['_id']},
                                 {'$set': {
                                     'username': user['username'],
                                     'token': server['token']
                                 }})
    else:
        print('Error updating report ' + str(report['_id']))
        print('Server ' + str(report['server_id']))
        mongo.reports.delete_many({'server_id': report['server_id']})

# Migrate servers
mongo.servers.update_many({}, {'$unset': {'nickname': 1}})
servers = mongo.servers.find({'username': None})
for server in servers:
    first_report = mongo.reports.find_one({'server_id': server['_id']})
    last_report = mongo.reports.find_one({'server_id': server['_id']}, sort=[('_id', -1)])

    if first_report is not None and last_report is not None:
        user = mongo.users.find_one({'_id': server['user_id']})
        ram_usage = 0
        try:
            ram_usage = round(last_report['ram_used'] * 100 / last_report['ram_total'])
        except:
            pass
        disk_usage = 0
        try:
            disk_usage = round(last_report['disk_used'] * 100 / last_report['disk_total'])
        except:
            pass
        mongo.servers.update_one({'_id': server['_id']},
                                 {'$set': {
                                     'username': user['username'],
                                     'first_report': first_report['created_at'],
                                     'last_report': last_report['created_at'],
                                     'ip': last_report['ip'],
                                     'hostname': last_report['hostname'],
                                     'distro': last_report['distro'],
                                     'uptime': last_report['uptime'],
                                     'ram_usage': ram_usage,
                                     'disk_usage': disk_usage
                                 }})
    else:
        print('Error updating server ' + str(server['_id']))
