// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham kiem tra thong tin dang nhap co chinh xac khong
exports.signUp = function (signUpInfo, socket){
    // Tach email
    let email = signUpInfo.USERNAME
    // Tach password
    let password = signUpInfo.PASSWORD;
    // Tach fullname
    let fullname = signUpInfo.FULLNAME;
    // Tach ngay sinh
    let birthday = signUpInfo.BIRTHDAY;
    // Tach gioi tinh
    let gender = signUpInfo.GENDER;
    // Tach truong
    let school = signUpInfo.SCHOOL;
    // Tach lop
    let classroom = signUpInfo.CLASSROOM;
    // In ra man hinh thong bao co nguoi dang ky
    commonFunction.consoleLog(email + ' is trying to sign up.');
    // Tien hanh them user vao co so du lieu
    // Khoi tao truy van
    var request = new server.sql.Request();
    // Khoi tao cau lenh them vao bang user
    var sqlQuery = `INSERT INTO [User] (Username, Password, Fullname, Birthday, Gender, School, Class) \
VALUES ('${email}', '${password}', N'${fullname}', '${birthday}', ${gender}, N'${school}', N'${classroom}')`
    // Them vao bang bang user, sau do goi callback
    request.query(sqlQuery, function (err, result) {
        // Tin nhan ket qua dang ky gui ve client
        var signUpResultMessage = null;
        // Neu co loi thi in ra loi
        if (err){
            // Neu truy van loi
            if(err.toString().indexOf("duplicate")) {
                // Neu email da ton tai
                signUpResultMessage = JSON.stringify({
                    COMMAND: "SIGNUP",
                    RESULT: "fail",
                    REASON: "ERROR_EMAIL_EXIST"
                });
                // Thong bao trung ban ghi
                commonFunction.consoleLog(`${email} sign up failed - ERROR_EMAIL_EXIST:`);
            } else {
                // Thong bao truy van sql loi
                commonFunction.consoleLog(`${email} sign up failed - UNKNOWN_ERROR:`);
                // Gui thong bao dang ky that bai ve client
                signUpResultMessage = JSON.stringify({
                    COMMAND: "SIGNUP",
                    RESULT: "fail",
                    REASON: "UNKNOWN_ERROR"
                });
            }
            // In ra thong tin loi
            commonFunction.consoleLog(err);
        } else{
            // Kiem tra xem co ban ghi nao duoc them khong
            if (result.rowsAffected.length == 0) {
                // Neu khong them duoc ban ghi tuc la trung email
                signUpResultMessage = JSON.stringify({
                    COMMAND: "SIGNUP",
                    RESULT: "fail",
                    REASON: "ERROR_EMAIL_EXIST"
                });
                // Thong bao trung ban ghi
                commonFunction.consoleLog(`${email} sign up failed - ERROR_EMAIL_EXIST:`);
            } else {
                // Neu them duoc ban ghi tuc la dang ky thanh cong
                commonFunction.consoleLog(`${email} sign up success!`)
                // Chuan bi thong tin user gui ve client
                signUpResultMessage = JSON.stringify({
                    COMMAND: "SIGNUP",
                    RESULT: "success",
                    USERNAME: email,
                    FULLNAME: fullname
                });
            }
        }
        // Gui ket qua dang ky ve client
        socket.emit('MESSAGE', signUpResultMessage);
    });
}