// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Khai bao lien ket sql server
const sql = require('mssql');
// Xuat bien sql
exports.sql = sql;
// Khai bao http
const http = require('http');
// File config server
const serverConfig = require('./config/serverConfig');
// Khai bao webserver
const express = require('express');
var app = express();
// Khoi tao server
var server = http.createServer(app);
// Lop quan ly dang nhap
var login = require("./login.js")
// Lop quan ly dang xuat
var logout = require("./logout.js")
// Lop quan ly dang ky
var signUp = require("./signUp.js")
// Lop quan ly tin tuc
var news = require("./news.js")
// Lop quan ly tour
var tour = require("./tour.js")
// Lop quan ly danh sach hoi thoai
var conversation = require("./conversation.js")
// Lop quan ly danh sach tu van vien
var counselor = require("./counselor.js")
// Lop quan ly toa do thanh vien
var memberLocation = require("./memberLocation.js")
// Lop quan ly ket noi socket
const io = require('socket.io').listen(server);
// Danh sach client ket noi den server
var sockets = [];
exports.sockets = sockets;
// Server lang nghe o cong 28146
server.listen(serverConfig.port);
// Test http post
app.post('/test', function(request, response) {
    commonFunction.consoleLog(request.body);
    // response.send('-- BS -- User Created! username: ' + request.query.username +
    //     ' password: ' +
    //     request.query.password);
});

// Tien hanh ket noi co so du lieu
sql.connect(serverConfig.database, function (err) {
    // Neu co loi thi in ra loi
    if (err) {
        if (err.code = 'ESOCKET') {
            // Mat ket noi csdl
            commonFunction.consoleLog('Connect to database error:');
        }  else {
            commonFunction.consoleLog('Connect to database error - UNKNOWN_ERROR:');
        }
        commonFunction.consoleLog(err);
    } else {
        // Neu khong co loi thi thong bao ket noi co so du lieu thanh cong
        commonFunction.consoleLog('Connected to database!');
		commonFunction.consoleLog('Server openned at ' + serverConfig.port);
    }
});
// Lang nghe ketnoi websocket
io.sockets.on('connection', (socket) => {
    // Thong bao co 1 ket noi moi
    commonFunction.consoleLog(`New connection from ${socket.conn.remoteAddress}`);
    // Them vao danh sach client
    sockets.push(socket);
    // Gui ve setting
    let getSettingSql = `SELECT * FROM [Setting]`;
    // Khoi tao truy van
    var request = new sql.Request();
    request.query(getSettingSql, function (err, recordset) {
        // Neu co loi thi in ra loi
        if (err){
            // Thong bao lay setting that bai
            if (err.code = 'ESOCKET') {
                // Mat ket noi csdl
                commonFunction.consoleLog('Connect to database error:');
            }  else {
                commonFunction.consoleLog(`${socket.conn.remoteAddress} get setting failed - UNKNOWN_ERROR:`);
            }
            commonFunction.consoleLog(err);
        } else{
            if (recordset.recordset.length > 0) {
                // Neu tim thay setting thi soan message gui ve client
                let settingJsonMessage = JSON.stringify({
                    COMMAND: "SETTING",
                    FORM_URL: recordset.recordset[0].FormUrl
                });
                // Gui message ve client
                socket.emit ("MESSAGE", settingJsonMessage);
                // Thong bao da gui setting
                commonFunction.consoleLog(`Sent setting to ${socket.conn.remoteAddress}!`);
            } else {
                // Neu khong tim thay setting nao thi in ra loi
                commonFunction.consoleLog('No setting found!');
            }
        }
    });
    // Xu ly khi nhan duoc test message
    socket.on('Test', function (testString) {
        commonFunction.consoleLog(`${new Date()} Test: ${testString}`);
        socket.emit('message', "Hi");
    });
    // Xu ly khi nhan duoc message tu client
    socket.on('MESSAGE', (messageData) => {
        // Phan tich message
        let jsonMessage = JSON.parse(messageData);
        // Kiem tra xem message thuoc loai gi
        switch (jsonMessage.COMMAND){
            case "LOGIN":
                // Neu la yeu cau dang nhap thi chuyen qua ham dang nhap
                login.login(jsonMessage, socket);
                break;
            case "LOGOUT":
                // Neu la yeu cau dang nhap thi chuyen qua ham dang nhap
                logout.logout(socket);
                break;
            case "SIGNUP":
                // Neu la yeu cau dang ky thi chuyen qua ham dang ky
                signUp.signUp(jsonMessage, socket);
                break;
            case "GET_NEWS_LIST":
                // Neu la yeu cau danh sach tin tuc thi chuyen qua ham lay danh sach tin tuc
                news.getNewsList(socket);
                break;
            case "GET_TOUR_LIST":
                // Neu la yeu cau danh sach tour thi chuyen qua ham lay danh sach tour
                tour.getTourList(jsonMessage.USER_ID, socket);
                break;
            case "MEMBER_CURRENT_LOCATION":
                // Neu la vi tri hien tai cua thanh vien thi chuyen qua ham cap nhat vi tri thanh vien
                memberLocation.memberLocation(jsonMessage, socket);
                break;
            case "GET_CONVERSATIONS_LIST":
                // Neu la yeu cau danh sach hoi thoai thi chuyen qua ham lay danh sach hoi thoai
                conversation.getConversationList(socket);
                break;
            case "GET_COUNSELORS_LIST":
                // Neu la yeu cau danh sach tu van vien thi chuyen qua ham lay danh sach tu van vien
                counselor.getCounselorsList(socket);
                break;
            case "MEMBER_MESSAGE":
                // Neu la tin nhan cua thanh vien thi chuyen qua ham xu ly tin nhan
                conversation.onMemberMessage(jsonMessage, socket);
                break;
            case "RECONNECT":
                // Neu la yeu cau ket noi lai thi chuyen qua ham xu ly ket noi lai
                login.reconnect(jsonMessage.USER_ID, socket);
                break;
            default:
                break;
        }
    });
    // Neu client bi mat ket noi thi thong bao
    socket.on('disconnect', function () {
        commonFunction.consoleLog(`Disconnected from ${socket.conn.remoteAddress}`);
        // Dang xuat neu co user id
        logout.logout(socket);
        // Loai bo client khoi danh sach
        sockets.splice(sockets.indexOf(socket), 1);
    })
});