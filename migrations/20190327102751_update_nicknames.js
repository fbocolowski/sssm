db.servers.find().snapshot().forEach(function (elem) {
    if (elem.hostname != null) {
        db.servers.update({
            _id: elem._id
        },{
            $set: {
                nickname: elem.hostname,
            }})
    }
});

db.servers.find().snapshot().forEach(function (elem) {
    db.servers.update({
        _id: elem._id
    },{
        $unset: {
            hostname: 1,
        }})
});