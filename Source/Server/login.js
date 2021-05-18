// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham kiem tra thong tin dang nhap co chinh xac khong
exports.login = async function (loginInfo, socket){
    // Tach email va password
    let email = loginInfo.USERNAME, password = loginInfo.PASSWORD;
    // Lay user id tu username
    let userId = await getUserId(email);
    if (userId == false) {
        // Neu co loi thi in ra loi
        commonFunction.consoleLog(`${email} login error!`);
        // Thoat khoi ham
        return;
    } else if (userId == 0) {
        // Neu khong tim thay user nao thi in ra loi
        commonFunction.consoleLog(`${email} not found!`);
    }
    // Kiem tra xem da co ai dang nhap vao tai khoan nay chua
    for (let i = 0; i < server.sockets.length; i++) {
        if (server.sockets[i].UserId != null && server.sockets[i].UserId == userId) {
            // Neu da co ai do dang nhap vao tai khoan thi in ra thong bao loi
            commonFunction.consoleLog(`${email} login conflict!`);
            // Soan message gui ve client
            let loginConflictMessage = JSON.stringify({
                COMMAND: "LOGIN",
                RESULT: "fail",
                REASON: "CONFLICT_ERROR"
            });
            // Gui message ve client
            socket.emit ("MESSAGE", loginConflictMessage);
            // Thoat khoi ham
            return;
        }
    }
    // In ra man hinh thong bao co nguoi dang nhap
    commonFunction.consoleLog(email + ' is trying to login.');
    // Tien hanh kiem tra trong co so du lieu
    // Khoi tao truy van
    var request = new server.sql.Request();
    // Khoi tao cau lenh truy van toi bang user
    var sqlQuery = `SELECT * FROM [User] WHERE Username = '${email}'\
    AND Password = '${password}'`
    // Truy van toi bang user, sau do goi callback
    request.query(sqlQuery, function (err, recordset) {
        // Tin nhan ket qua dang nhap gui ve client
        var loginResultMessage = null;
        // Neu co loi thi in ra loi
        if (err){
            // Thong bao dang nhap that bai
            if (err.code = 'ESOCKET') {
                // Mat ket noi csdl
                commonFunction.consoleLog('Connect to database error:');
            }  else {
                commonFunction.consoleLog(`${email} login failed - UNKNOWN_ERROR:`);
            }
            commonFunction.consoleLog(err);
            // Gui thong bao dang nhap that bai ve client
            loginResultMessage = JSON.stringify({
                COMMAND: "LOGIN",
                RESULT: "fail",
                REASON: "UNKNOWN_ERROR"
            });
        } else{
            // Kiem tra xem co ban ghi nao duoc tim thay khong
            if (recordset.recordset.length == 0) {
                // Neu khong tim thay ban ghi nao thi thong bao sai email/mat khau
                commonFunction.consoleLog(`${email} login failed - WRONG_EMAIL_PASSWORD`)
                // Chuan bi thong bao sai thong tin dang nhap gui ve client
                loginResultMessage = JSON.stringify({
                    COMMAND: "LOGIN",
                    RESULT: "fail",
                    REASON: "WRONG_EMAIL_PASSWORD"
                });
            } else {
                // Neu tim thay 1 ban ghi thi thong bao dang nhap thanh cong
                commonFunction.consoleLog(`${email} login success! Name: ${recordset.recordset[0].Fullname}`)
                // Thay doi trang thai cua user thanh online
                var userInfo = recordset.recordset[0];
                var sqlOnlineQuery = `UPDATE [User] SET State = 1 WHERE UserId = ${userInfo.UserId}`;
                // Thuc hien truy van danh dau user online
                request.query(sqlQuery, function (stateErr, stateRecordset) {
                    // Neu co loi thi in ra loi
                    if (stateErr) {
                        // Thong bao update state that bai
                        commonFunction.consoleLog(`Update user ${email}'s state failed - UNKNOWN_ERROR`);
                        commonFunction.consoleLog(stateErr);
                    }
                });
                // Reformat ngay
                let date = new Date(userInfo.Birthday);
                // Chuan bi thong tin user gui ve client
                loginResultMessage = JSON.stringify({
                    COMMAND: "LOGIN",
                    RESULT: "success",
                    USER_ID: userInfo.UserId,
                    USERNAME: userInfo.Username,
                    FULLNAME: userInfo.Fullname,
                    BIRTHDAY: `${String("0" + date.getUTCDate()).slice(-2)}-\
${String("0" + (date.getUTCMonth()+1)).slice(-2)}-${date.getUTCFullYear()}`,
                    GENDER: userInfo.Gender,
                    SCHOOL: userInfo.School,
                    CLASS: userInfo.Class,
                    PHONE_NUMBER: userInfo.PhoneNumber,
                    IS_COUNSELOR: userInfo.IsCounselor,
                    STATE: userInfo.State
                });
            }
            // Gui ket qua dang nhap ve client
            socket.emit('MESSAGE', loginResultMessage);
            // Gan user id cho socket
            socket.UserId = userInfo.UserId;
            /* Gui thong bao member online ve client */
            // Khoi tao cau lenh truy van toi bang Tour2Member
            var memberOnlineSql = `SELECT DISTINCT UserId FROM Tour2Member 
WHERE TourId IN (SELECT TourId FROM Tour2Member WHERE UserId = ${socket.UserId})`
            // Truy van toi bang Tour2Member, sau do goi callback
            request.query(memberOnlineSql, function (err, recordset) {
                // Tin nhan thong bao member online gui ve client
                var memberOnlineResultMessage = null;
                // Neu co loi thi in ra loi
                if (err) {
                    // Thong bao truy van member that bai
                    if (err.code = 'ESOCKET') {
                        // Mat ket noi csdl
                        commonFunction.consoleLog('Connect to database error:');
                    } else {
                        commonFunction.consoleLog(`${socket.UserId} excute member online sql failed - UNKNOWN_ERROR:`);
                    }
                    commonFunction.consoleLog(err);
                } else {
                    // Kiem tra xem co ban ghi nao duoc tim thay khong
                    if (recordset.recordset.length > 0) {
                        // Neu tim thay 1 ban ghi thi soan message gui ve client
                        memberOnlineResultMessage = JSON.stringify({
                            COMMAND: "MEMBER_ONLINE",
                            USER_ID: socket.UserId
                        });
                        // Kiem tra danh sach socket ket noi den server xem co ai cung tour voi minh khong
                        for (let i = 0; i < server.sockets.length; i++) {
                            // Vong lap danh sach socket
                            if (server.sockets[i].UserId != null) {
                                for (let j = 0; j < recordset.recordset.length; j++) {
                                    // Vong lap danh sach user id sau khi truy van
                                    if (server.sockets[i].UserId == recordset.recordset[j].UserId) {
                                        // Neu socket dang ket noi den servver co User Id nam trong danh sach
                                        // User Id vua truy van thi gui message ve
                                        server.sockets[i].emit('MESSAGE', memberOnlineResultMessage);
                                    }
                                }
                            }
                        }
                    }
                }
            });
        }
    });
}

// Ham lay ten user id dua vao ten dang nhap
function getUserId(userName) {
    return new Promise(resolve => {
        let getUserIdSql = `SELECT UserId FROM [User] WHERE UserName = '${userName}'`;
        // Khoi tao truy van
        var request = new server.sql.Request();
        request.query(getUserIdSql, function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao lay user id that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`${socket.conn.remoteAddress} get user ${userName} id failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
                resolve(false);
            } else{
                if (recordset.recordset.length == 1) {
                    // Neu tim thay user thi tra ve user id
                    resolve(recordset.recordset[0].UserId);
                } else {
                    // Neu khong tim thay user nao thi tra ve 0
                    resolve(0);
                }
            }
        });
    });
}

// Ham xu ly yeu cau ket noi lai cua client
exports.reconnect = function (userId, socket){
    // Gan user id cua socket hien tai
    socket.UserId = userId;
    reconnectResultMessage = JSON.stringify({
        COMMAND: "RECONNECT",
        RESULT: "success"
    });
    // Gui ket qua ket noi lai thanh cong ve client
    socket.emit('MESSAGE', reconnectResultMessage);
    // In ra thong bao client ket noi lai thanh congs
    commonFunction.consoleLog(`User id ${userId} reconnected success!`);
}