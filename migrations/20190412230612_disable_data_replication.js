db.sessions.updateMany({}, {$unset: {username: 1}})
db.servers.updateMany({}, {$unset: {username: 1}})
db.reports.updateMany({}, {$unset: {username: 1, token: 1}})