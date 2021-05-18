// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham phan tich vi tri thanh vien
exports.memberLocation = function (locationData, socket){
    try {
        // Cap nhat vi tri cua member
        let updateMemberLocation = `UPDATE Tour2Member set mLocation = \
'POINT(${locationData.LATITUDE} ${locationData.LONGITUDE})' WHERE UserId = ${socket.UserId}`;
        // Khoi tao truy van
        var request = new server.sql.Request();
        // Truy van toi bang user, sau do goi callback
        request.query(updateMemberLocation, function (stateErr, stateRecordset) {
            // Neu co loi thi in ra loi
            if (stateErr) {
                // Thong bao update location that bai
                commonFunction.consoleLog(`Update user ${socket.UserId}'s location failed - UNKNOWN_ERROR`);
                commonFunction.consoleLog(stateErr);
            } else {
                // Thong bao cap nhat vi tri thanh cong
                commonFunction.consoleLog(`User ${socket.UserId}'s location updated!`);
                // Tim kiem tat ca user id co mat trong cac tour cua user nay
                let getUserList =
                    `SELECT UserId FROM Tour2Member WHERE TourId IN (SELECT TourId FROM Tour2Member WHERE UserId = ${socket.UserId})`;
                let users = [];
                request.query(getUserList, function (err, recordset) {
                    // Neu co loi thi in ra loi
                    if (err){
                        // Thong bao dang lay danh sach thanh vien that bai
                        // Mat ket noi csdl
                        if (err.code = 'ESOCKET') {
                            commonFunction.consoleLog('Connect to database error:');
                        }  else {
                            commonFunction.consoleLog(`Getting manager list from timesheet id ${timesheetId} failed - UNKNOWN_ERROR:`);
                        }
                        commonFunction.consoleLog(err);
                    } else {
                        // Duyet tung thanh vien
                        for (let i = 0; i < recordset.recordset.length; i++) {
                            // Kiem tra xem co socket nao trung user id dang ket noi khong
                            for (let j = 0; j < server.sockets.length; j++) {
                                if (server.sockets[j].UserId == recordset.recordset[i].UserId){
                                    // Gui toa do ve client
                                    memberLocationResultMessage = JSON.stringify({
                                        COMMAND: "MEMBER_LOCATION_CHANGE",
                                        USER_ID: 3,
                                        LATITUDE: locationData.LATITUDE,
                                        LONGITUDE: locationData.LONGITUDE
                                    });
                                    server.sockets[j].emit('MESSAGE', memberLocationResultMessage);
                                }
                            }
                        }
                    }
                });
            }
        });
    } catch (exception) {
        commonFunction.consoleLog(`[ERROR] exception update member location: ${exception}, exception stack: ${exception.stack}`)
    }
}