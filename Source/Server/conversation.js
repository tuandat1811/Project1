// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham lay danh sach hoi thoai
// exports.getConversationList = function (){
exports.getConversationList = function (socket){
    try {
        // Lay danh sach hoi thoai
        let selectConversationQuery = `SELECT * FROM [Message] WHERE SenderId = \
${socket.UserId} OR RecieverId = ${socket.UserId} ORDER BY [Time] ASC`;
        // Command gui ve client
        let conversationsListMessage = {COMMAND: "CONVERSATIONS_LIST", CONVERSATIONS_LIST: []};
        let conversationsList = [];
        // Khoi tao truy van
        var request = new server.sql.Request();
        // Truy van toi bang message, sau do goi callback
        request.query(selectConversationQuery, async function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao dang lay danh sach hoi thoai that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`${socket.UserId} get conversations list failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
            } else{
                // Neu tim thay 1 ban ghi thi khoi tao danh sach hoi thoai
                // Duyet tung hoi thoai cua ket qua truy van
                for (let i = 0; i < recordset.recordset.length; i++) {
                    // Gan doan hoi thoai hien tai cua ket qua truy van
                    let currentQueryConversation = recordset.recordset[i];
                    // Danh dau tim thay doan hoi thoai voi nguoi tuong tu trong csdl
                    let found = false;
                    // Duyet tung doan hoi thoai trong message gui ve client
                    for (let j = 0; j < conversationsList.length; j++) {
                        /* Kiem tra xem trong doan hoi thoai hien tai gui ve client da co
                        user id nay chua */
                        if (conversationsList[j].PARTNER_ID === currentQueryConversation.SenderId) {
                            // Neu doi phuong la nguoi gui thi khoi tao 1 tin nhan
                            let currentMessage = {
                                IS_SENDER: false,
                                CONTENT: currentQueryConversation.mContent,
                                TIME:`${String("0" + currentQueryConversation.Time.getUTCDate()).slice(-2)}-\
${String("0" + (currentQueryConversation.Time.getUTCMonth()+1)).slice(-2)}-\
${currentQueryConversation.Time.getUTCFullYear()} \
${String("0" + currentQueryConversation.Time.getUTCHours()).slice(-2)}:\
${String("0" + currentQueryConversation.Time.getUTCMinutes()).slice(-2)}`
                            }
                            // Them vao danh sach tin nhan gui ve client
                            conversationsList[j].MESSAGES.push(currentMessage);
                            // Danh dau da tim thay 1 doan hoi thoai voi nguoi tuong tu trong csdl
                            found = true;
                            // Thoai khoi vong lap duyet danh sach hoi thoai trong message gui ve client
                            break;
                        } else if (conversationsList[j].PARTNER_ID === currentQueryConversation.RecieverId) {
                            // Neu User nay la nguoi gui thi khoi tao 1 tin nhan
                            let currentMessage = {
                                IS_SENDER: true,
                                CONTENT: currentQueryConversation.mContent,
                                TIME:`${String("0" + currentQueryConversation.Time.getUTCDate()).slice(-2)}-\
${String("0" + (currentQueryConversation.Time.getUTCMonth()+1)).slice(-2)}-\
${currentQueryConversation.Time.getUTCFullYear()} \
${String("0" + currentQueryConversation.Time.getUTCHours()).slice(-2)}:\
${String("0" + currentQueryConversation.Time.getUTCMinutes()).slice(-2)}`
                            }
                            // Them vao danh sach tin nhan gui ve client
                            conversationsList[j].MESSAGES.push(currentMessage);
                            // Danh dau da tim thay 1 doan hoi thoai voi nguoi tuong tu trong csdl
                            found = true;
                            // Thoai khoi vong lap duyet danh sach hoi thoai trong message gui ve client
                            break;
                        }
                    }
                    // Kiem tra xem co tim thay doan hoi thoai voi nguoi tuong tu trong csdl khong
                    if (found == false){
                        // Neu khong tim thay ai ca thi them 1 doan hoi thoai vao Json message gui ve client
                        if (socket.UserId === currentQueryConversation.SenderId) {
                            // Neu User nay la nguoi gui thi khoi tao 1 doan hoi thoai
                            let currentConversation = {
                                PARTNER_ID: currentQueryConversation.RecieverId,
                                PARTNER_NAME: await getUserFullname(currentQueryConversation.RecieverId),
                                MESSAGES: []
                            };
                            // Khoi tao doan tin nhan
                            let currentMessage = {
                                IS_SENDER: true,
                                CONTENT: currentQueryConversation.mContent,
                                TIME:`${String("0" + currentQueryConversation.Time.getUTCDate()).slice(-2)}-\
${String("0" + (currentQueryConversation.Time.getUTCMonth()+1)).slice(-2)}-\
${currentQueryConversation.Time.getUTCFullYear()} \
${String("0" + currentQueryConversation.Time.getUTCHours()).slice(-2)}:\
${String("0" + currentQueryConversation.Time.getUTCMinutes()).slice(-2)}`
                            }
                            // Them vao danh sach tin nhan
                            currentConversation.MESSAGES.push(currentMessage);
                            // Them vao 1 doan hoi thoai gui ve client
                            conversationsList.push(currentConversation);
                        } else if (socket.UserId === currentQueryConversation.RecieverId) {
                            // Neu User nay la nguoi nhan thi khoi tao 1 doan hoi thoai
                            let currentConversation = {
                                PARTNER_ID: currentQueryConversation.SenderId,
                                PARTNER_NAME: await getUserFullname(currentQueryConversation.SenderId),
                                MESSAGES: []
                            };
                            // Khoi tao doan tin nhan
                            let currentMessage = {
                                IS_SENDER: false,
                                CONTENT: currentQueryConversation.mContent,
                                TIME:`${String("0" + currentQueryConversation.Time.getUTCDate()).slice(-2)}-\
${String("0" + (currentQueryConversation.Time.getUTCMonth()+1)).slice(-2)}-\
${currentQueryConversation.Time.getUTCFullYear()} \
${String("0" + currentQueryConversation.Time.getUTCHours()).slice(-2)}:\
${String("0" + currentQueryConversation.Time.getUTCMinutes()).slice(-2)}`
                            }
                            // Them vao danh sach tin nhan
                            currentConversation.MESSAGES.push(currentMessage);
                            // Them vao 1 doan hoi thoai gui ve client
                            conversationsList.push(currentConversation);
                        }
                    }
                }
                // Gan danh sach hoi thoai
                conversationsListMessage.CONVERSATIONS_LIST = conversationsList;
            }
            // Gui danh sach hoi thoai ve client
            // commonFunction.consoleLog("a")
            socket.emit('MESSAGE', JSON.stringify(conversationsListMessage));
        });
    } catch (exception) {
        commonFunction.consoleLog(`[ERROR] exception getting conversations list: ${exception}, exception stack: ${exception.stack}`)
    }
}

// Ham lay ten nguoi dung dua vao User id
function getUserFullname(UserId) {
    return new Promise(resolve => {
        let getUserFullnameSql = `SELECT Fullname FROM [User] WHERE UserId = ${UserId}`;
        // Khoi tao truy van
        var request = new server.sql.Request();
        request.query(getUserFullnameSql, function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao lay ten day du that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`${socket.UserId} get user ${UserId} fullname failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
                resolve(false);
            } else{
                if (recordset.recordset.length == 1) {
                    resolve(recordset.recordset[0].Fullname);
                } else {
                    commonFunction.consoleLog(`${socket.UserId} get user ${UserId} fullname failed - recordset length: ${recordset.recordset.length}`);
                    resolve(false);
                }
            }
        });
    });
}

// Ham xu ly tin nhan giua cac thanh vien
exports.onMemberMessage = function (messageData, socket){
    // Tach reciever id
    let recieverId = messageData.RECIEVER_ID
    // Tach ten nguoi nhan tin
    let senderName = messageData.SENDER_NAME
    // Tach ten nguoi nhan
    let recieverName = messageData.RECIEVER_NAME;
    // Tach noi dung tin nhan
    let content = messageData.CONTENT;
    // Tien hanh them tin nhan vao co so du lieu
    // Khoi tao truy van
    var request = new server.sql.Request();
    // Khoi tao cau lenh them vao bang message
    var sqlQuery = `INSERT INTO [Message] (SenderId, RecieverId, mContent, [Time])\
VALUES (${socket.UserId}, ${recieverId}, N'${content}', getDate())`
    // Them vao bang bang message, sau do goi callback
    request.query(sqlQuery, function (err, result) {
        // Ket qua gui tin nhan gui cho client
        var sendMessageResultMessage = null;
        // Neu co loi thi in ra loi
        if (err){
            // Thong bao truy van sql loi
            commonFunction.consoleLog(`${socket.UserId} send message failed - UNKNOWN_ERROR:`);
            // Gui thong bao gui tin nhan that bai ve client
            sendMessageResultMessage = JSON.stringify({
                COMMAND: "MEMBER_MESSAGE",
                RESULT: "fail",
                REASON: "UNKNOWN_ERROR"
            });
            // In ra thong tin loi
            commonFunction.consoleLog(err);
        } else{
            // Kiem tra xem co ban ghi nao duoc them khong
            if (result.rowsAffected.length == 0) {
                // Neu khong them duoc ban ghi thi tra ve loi
                sendMessageResultMessage = JSON.stringify({
                    COMMAND: "MEMBER_MESSAGE",
                    RESULT: "fail",
                    REASON: "UNKNOWN_ERROR"
                });
                // Thong bao trung ban ghi
                commonFunction.consoleLog(`${socket.UserId} send message failed - UNKNOWN_ERROR:`);
            } else {
                // Neu them duoc ban ghi tuc la gui tin nhan thanh cong
                commonFunction.consoleLog(`${socket.UserId} send message success!`)
                // Chuan bi tin nhan gui ve client
                let currentTime = new Date();
                sendMessageResultMessage = JSON.stringify({
                    COMMAND: "MEMBER_MESSAGE",
                    RESULT: "success",
                    SENDER_ID: socket.UserId,
                    SENDER_NAME: senderName,
                    RECIEVER_ID: recieverId,
                    RECIEVER_NAME: recieverName,
                    CONTENT: content,
                    TIME: `${String("0" + currentTime.getDate()).slice(-2)}-\
${String("0" + (currentTime.getMonth()+1)).slice(-2)}-\
${currentTime.getFullYear()} \
${String("0" + currentTime.getHours()).slice(-2)}:\
${String("0" + currentTime.getMinutes()).slice(-2)}`
                });
            }
        }
        // Gui ket qua nhan tin ve client nhan
        for (let i = 0; i < server.sockets.length; i++) {
            if (server.sockets[i].UserId != null && server.sockets[i].UserId == recieverId){
                server.sockets[i].emit('MESSAGE', sendMessageResultMessage);
            }
        }
        // Gui ket qua tin nhan ve client gui
        socket.emit('MESSAGE', sendMessageResultMessage);
    });
}