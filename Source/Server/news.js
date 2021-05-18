// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham lay danh sach tin tuc
exports.getNewsList = function (socket){
    try {
        let newsListMessage = {COMMAND: "GET_NEWS_LIST", NEWS: []};
        let getNewsListQuery = `SELECT * FROM News WHERE IsShowing = 'True'`;
        let newsList = [];
        // Khoi tao truy van
        var request = new server.sql.Request();
        // Truy van toi bang news, sau do goi callback
        request.query(getNewsListQuery, function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao dang lay danh sach tin tuc that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`${email} login failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
            } else{
                // Neu tim thay 1 ban ghi thi gan danh sach tin tuc
                // Duyet tung tin tuc
                for (let i = 0; i < recordset.recordset.length; i++) {
                    let news = {
                        NEWS_ID: recordset.recordset[i].NewsId,
                        IMAGE_URL: recordset.recordset[i].ImageUrl,
                        TITLE: recordset.recordset[i].Title,
                        URL: recordset.recordset[i].Url,
                        SUMMARY: recordset.recordset[i].Summary
                    };
                    newsList[i] = news;
                }
                // Gan danh sach tin tuc
                newsListMessage.NEWS = newsList;
            }
            // Gui danh sach tin tuc ve client
            socket.emit('MESSAGE', JSON.stringify(newsListMessage));
        });
    } catch (exception) {
        commonFunction.consoleLog(`[ERROR] exception get news list: ${exception}, exception stack: ${exception.stack}`)
    }
}