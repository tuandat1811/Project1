// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham lay danh sach tu van vien
exports.getCounselorsList = function (socket){
    try {
        // Lay danh sach tu van vien
        let selectCounselorsQuery = `SELECT UserId, Username, Fullname, Gender, State FROM [User] WHERE IsCounselor = '1' ORDER BY UserId ASC;`;
        // Command gui ve client
        let counselorsListMessage = {COMMAND: "COUNSELORS_LIST", COUNSELORS_LIST: []};
        let counselorsList = [];
        // Khoi tao truy van
        var request = new server.sql.Request();
        // Truy van toi bang User, sau do goi callback
        request.query(selectCounselorsQuery, function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao dang lay danh sach tu van vien that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`${socket.UserId} get counselors list failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
            } else{
                // Neu tim thay 1 ban ghi thi khoi tao danh sach tu van vien
                // Duyet tung tu van vien cua ket qua truy van
                for (let i = 0; i < recordset.recordset.length; i++) {
                    // Gan tu van vien hien tai cua ket qua truy van
                    let currentQueryCounselor = recordset.recordset[i];
                    // Khoi tao 1 tu van vien
                    let currentCounselor = {
                        USER_ID: currentQueryCounselor.UserId,
                        USERNAME: currentQueryCounselor.Username,
                        FULLNAME: currentQueryCounselor.Fullname,
                        GENDER: currentQueryCounselor.Gender,
                        STATE: currentQueryCounselor.State
                    }
                    // Them vao danh sach tu van vien gui ve client
                    counselorsList.push(currentCounselor);
                }
                // Gan danh sach tu van vien
                counselorsListMessage.COUNSELORS_LIST = counselorsList;
            }
            // Gui danh sach tu van vien ve client
            socket.emit('MESSAGE', JSON.stringify(counselorsListMessage));
        });
    } catch (exception) {
        commonFunction.consoleLog(`[ERROR] exception getting counselors list: ${exception}, exception stack: ${exception.stack}`)
    }
}