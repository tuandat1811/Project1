// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham dang xuat
exports.logout = function (socket){
    // Kiem tra xem socket co chua user id khong
    if (socket.UserId != null) {
        // In ra man hinh thong bao co nguoi dang xuat
        commonFunction.consoleLog(`UserId ${socket.UserId} is trying to logout.`);
        // Tien hanh truy van co so du lieu
        // Khoi tao truy van
        var request = new server.sql.Request();
        // Khoi tao cau lenh truy van toi bang user
        var sqlQuery = `UPDATE [User] SET State = 0 WHERE UserId = ${socket.UserId}`
        // Truy van toi bang user, sau do goi callback
        request.query(sqlQuery, function (stateErr, stateRecordset) {
            // Tin nhan ket qua dang xuat gui ve client
            var logoutResultMessage = null;
            // Neu co loi thi in ra loi
            if (stateErr) {
                // Thong bao update state that bai
                commonFunction.consoleLog(`Update user ${socket.UserId}'s state failed - UNKNOWN_ERROR`);
                commonFunction.consoleLog(stateErr);
                // Gui thong bao dang xuat that bai ve client
                logoutResultMessage = JSON.stringify({
                    COMMAND: "LOGOUT",
                    RESULT: "fail",
                    REASON: "UNKNOWN_ERROR"
                });
            } else {
                // Thong bao dang xuat thanh cong
                commonFunction.consoleLog(`User ${socket.UserId}'s logout success!`);
                logoutResultMessage = JSON.stringify({
                    COMMAND: "LOGOUT",
                    RESULT: "success"
                });
            }
            // Gui ket qua dang xuat ve client
            socket.emit('MESSAGE', logoutResultMessage);
            // Xoa user id trong socket
            socket.UserId = null;
        });
    }
}