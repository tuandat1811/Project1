// Cac ham dung chung
const commonFunction = require("./commonFunction.js");
// Lien ket den class server
const server = require("./server.js");
// Ham lay danh sach tour
exports.getTourList = function (userid, socket){
    try {
        let tourListMessage = {COMMAND: "GET_TOUR_LIST", TOURS: []};
        // Lay danh sach tour
        let getTourListQuery = `SELECT Tour.TourId, Tour.Name, Tour.[Date], Tour.ImageUrl, Tour2Member.mFunction, Tour.MapImageUrl \
FROM Tour, Tour2Member WHERE Tour.TourId = Tour2Member.TourId AND Tour.[State] = 1 AND Tour2Member.UserId = ${userid}`;
        // Danh sach tour
        let tourList = [];
        // Khoi tao truy van
        var request = new server.sql.Request();
        // Truy van toi bang tour, sau do goi callback
        request.query(getTourListQuery, async function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao dang lay danh sach tour that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`Getting tour list from user id ${userid} failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
            } else {
                // Neu tim thay 1 ban ghi thi gan danh sach tour
                // Duyet tung tour
                for (let i = 0; i < recordset.recordset.length; i++) {
                    // Reformat ngay
                    let date = new Date(recordset.recordset[i].Date);
                    let mTour = {
                        TOUR_ID: recordset.recordset[i].TourId,
                        NAME: recordset.recordset[i].Name,
                        DATE: `${String("0" + date.getUTCDate()).slice(-2)}-\
${String("0" + (date.getUTCMonth()+1)).slice(-2)}-${date.getUTCFullYear()}`,
                        IMAGE_URL: recordset.recordset[i].ImageUrl,
                        MAP_IMAGE_URL: recordset.recordset[i].MapImageUrl,
                        FUNCTION: recordset.recordset[i].mFunction,
                        MEMBERS:[], TIMESHEETS:[]
                    };
                    // Lay danh sach member
                    let members = await getMemberList(mTour.TOUR_ID, request);
                    mTour.MEMBERS = members.members;
                    // Lay danh sach chang
                    let timesheets = await getTimesheetList(mTour.TOUR_ID, request);
                    mTour.TIMESHEETS = timesheets.timesheets;
                    tourList[i] = mTour;
                }
                // Gan danh sach tour
                tourListMessage.TOURS = tourList;
            }
            // Gui danh sach tour ve client
            socket.emit('MESSAGE', JSON.stringify(tourListMessage));
        });
    } catch (exception) {
        commonFunction.consoleLog(`[ERROR] exception get tour list: ${exception}, exception stack: ${exception.stack}`)
    }
}

// Ham lay danh sach thanh vien 1 tour
function getMemberList(tourId, request) {
    // Lay danh sach thanh vien trong 1 tour
    return new Promise(resolve => {
        // Cau truy van lay danh sach thanh vien
        let getMemberListSql = `SELECT [User].UserId, Tour2Member.mFunction, Tour2Member.mLocation, \
Tour2Member.Note, [User].Username, [User].Fullname, [User].Birthday, [User].Gender, [User].School, \
[User].Class, [User].IsCounselor, [User].[State], [User].PhoneNumber FROM [User], Tour2Member
WHERE [User].UserId = Tour2Member.UserId AND Tour2Member.TourId = ${tourId}`;
        let members = [];
        request.query(getMemberListSql, function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao dang lay danh sach thanh vien that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`Getting members list from tour id ${tourId} failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
            } else {
                // Duyet tung thanh vien
                for (let i = 0; i < recordset.recordset.length; i++) {
                    // Toa do cua member tren google map
                    let latitude = null;
                    let longitude = null;
                    if (recordset.recordset[i].mLocation != null){
                        latitude = recordset.recordset[i].mLocation.points[0].x;
                        longitude = recordset.recordset[i].mLocation.points[0].y
                    }
                    let member = {
                        USER_ID: recordset.recordset[i].UserId,
                        FUNCTION: recordset.recordset[i].mFunction,
                        LATITUDE: latitude,
                        LONGITUDE: longitude,
                        NOTE: recordset.recordset[i].Note,
                        USERNAME: recordset.recordset[i].Username,
                        FULLNAME: recordset.recordset[i].Fullname,
                        BIRTHDAY: recordset.recordset[i].Birthday,
                        GENDER: recordset.recordset[i].Gender,
                        SCHOOL: recordset.recordset[i].School,
                        CLASS: recordset.recordset[i].Class,
                        PHONE_NUMBER: recordset.recordset[i].PhoneNumber,
                        IS_COUNSELOR: recordset.recordset[i].IsCounselor,
                        STATE: recordset.recordset[i].State
                    };
                    members[i] = member;
                }
                resolve({members: members});
            }
        });
    });
}

// Ham lay danh sach chang trong 1 tour
function getTimesheetList(tourId, request) {
    // Lay danh sach chang trong 1 tour
    return new Promise(resolve => {
        // Cau truy van lay danh sach chang
        let getTimesheetListSql =
`SELECT Timesheet2Classroom.TimesheetId, Timesheet.StartTime, Timesheet.EndTime, \
Classroom.ClassroomId, Classroom.[Floor], Classroom.[Name] AS ClassroomName, Building.Note AS BuildingNote, \
Classroom.SubName AS ClassroomSubName, Classroom.Note AS ClassroomNote, Building.[Name] AS BuildingName, \
Building.SubName AS BuildingSubName, Building.[Location] AS BuildingLocation \
FROM Building, Building2Classroom, Classroom, Timesheet2Classroom, Tour2Timesheet, Timesheet \
WHERE Building.BuildingId = Building2Classroom.BuildingId \
AND Building2Classroom.ClassroomId = Classroom.ClassroomId \
AND Classroom.ClassroomId = Timesheet2Classroom.ClassroomId \
AND Timesheet.TimesheetId = Timesheet2Classroom.TimesheetId \
AND Timesheet.TimesheetId = Tour2Timesheet.TimesheetId \
AND Tour2Timesheet.TourId  = ${tourId} \
ORDER BY Timesheet2Classroom.TimesheetId`;
        let timesheets = [];
        request.query(getTimesheetListSql, async function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao dang lay danh sach chang that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`Getting timesheet list from tour id ${tourId} failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
            } else {
                // Duyet tung chang
                for (let i = 0; i < recordset.recordset.length; i++) {
                    // Toa do toa nha
                    let latitude = null;
                    let longitude = null;
                    if (recordset.recordset[i].BuildingLocation != null){
                        latitude = recordset.recordset[i].BuildingLocation.points[0].x;
                        longitude = recordset.recordset[i].BuildingLocation.points[0].y
                    }
                    // Reformat gio
                    let startTime = new Date(recordset.recordset[i].StartTime);
                    let endTime = new Date(recordset.recordset[i].EndTime);
                    let timesheet = {
                        TIMESHEET_ID: recordset.recordset[i].TimesheetId,
                        START_TIME: `${String("0" + startTime.getUTCHours()).slice(-2)}:\
${String("0" + (startTime.getUTCMinutes())).slice(-2)}:\
${String("0" + (startTime.getUTCSeconds())).slice(-2)}`,
                        END_TIME: `${String("0" + endTime.getUTCHours()).slice(-2)}:\
${String("0" + (endTime.getUTCMinutes())).slice(-2)}:\
${String("0" + (endTime.getUTCSeconds())).slice(-2)}`,
                        CLASSROOMS_ID: recordset.recordset[i].ClassroomId,
                        CLASSROOM_FLOOR: recordset.recordset[i].Floor,
                        CLASSROOMS_NAME: recordset.recordset[i].ClassroomName,
                        CLASSROOM_SUB_NAME: recordset.recordset[i].ClassroomSubName,
                        CLASSROOMS_NOTE: recordset.recordset[i].ClassroomNote,
                        BUILDING_NAME: recordset.recordset[i].BuildingName,
                        BUILDING_SUB_NAME: recordset.recordset[i].BuildingSubName,
                        LATITUDE: latitude,
                        LONGITUDE: longitude,
                        BUILDING_NOTE: recordset.recordset[i].BuildingNote,
                        MANAGERS: []
                    };
                    // Lay danh sach nguoi quan ly
                    let managers = await getManagerList(recordset.recordset[i].TimesheetId, request);
                    timesheet.MANAGERS = managers.managers;
                    timesheets[i] = timesheet;
                }
                resolve({timesheets: timesheets});
            }
        });
    });
}

// Ham lay danh sach nguoi quan ly lop hoc
function getManagerList(timesheetId, request) {
    // Lay danh sach nguoi quan ly trong 1 chang
    return new Promise(resolve => {
        // Cau truy van lay danh sach nguoi quan ly
        let getManagerList =
`SELECT Manager.ManagerId, Manager.[Name], Manager.Gender, Manager.Birthday, Manager.Email, \
Manager.PhoneNumber FROM Timesheet, Manager, Timesheet2Classroom \
WHERE Timesheet.TimesheetId = Timesheet2Classroom.TimesheetId \
AND Manager.ManagerId = Timesheet2Classroom.ManagerId \
AND Timesheet2Classroom.TimesheetId = ${timesheetId} \
ORDER BY Timesheet2Classroom.ManagerId`;
        let managers = [];
        request.query(getManagerList, function (err, recordset) {
            // Neu co loi thi in ra loi
            if (err){
                // Thong bao dang lay danh sach nguoi quan ly that bai
                if (err.code = 'ESOCKET') {
                    // Mat ket noi csdl
                    commonFunction.consoleLog('Connect to database error:');
                }  else {
                    commonFunction.consoleLog(`Getting manager list from timesheet id ${timesheetId} failed - UNKNOWN_ERROR:`);
                }
                commonFunction.consoleLog(err);
            } else {
                // Duyet tung nguoi quan ly
                for (let i = 0; i < recordset.recordset.length; i++) {
                    // Reformat ngay sinh
                    let birthday = new Date(recordset.recordset[i].Birthday);
                    let manager = {
                        MANAGER_ID: recordset.recordset[i].ManagerId,
                        NAME: recordset.recordset[i].Name,
                        GENDER: recordset.recordset[i].Gender,
                        BIRTHDAY: `${String("0" + birthday.getUTCDate()).slice(-2)}-\
${String("0" + (birthday.getUTCMonth()+1)).slice(-2)}-${birthday.getUTCFullYear()}`,
                        EMAIL: recordset.recordset[i].Email,
                        PHONE_NUMBER: recordset.recordset[i].PhoneNumber
                    };
                    manager.MANAGERS = managers.managers;
                    managers[i] = manager;
                }
                resolve({managers: managers});
            }
        });
    });
}