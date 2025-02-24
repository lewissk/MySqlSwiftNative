//
//  MySQLDriverMacTests.swift
//  MySQLDriverMacTests
//
//  Created by cipi on 25/12/15.
//
//

import XCTest

@testable import MySQLDriver

class MySQLDriverMacTests: XCTestCase {
    let con = MySQL.Connection()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            try con.open("192.168.1.122", user: "test", passwd: "test", dbname: "swift_test")
            XCTAssertNotNil(con)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        do {
            try con.close()
        }
        catch(let e) {
            XCTAssertNil(e)
        }

        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreateConnection() {
        let con = MySQL.Connection()
        do {
            try con.open("192.168.1.122", user: "test", passwd: "test", dbname: "swift_test")
            XCTAssertNotNil(con)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testCloseConnection() {
        let con = MySQL.Connection()
        do {
            try con.open("localhost", user: "test", passwd: "test", dbname: "swift_test")
            try con.close()
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testUse() {
        let con = MySQL.Connection()
        do {
            try con.open("localhost", user: "test", passwd: "test")
            try con.use("swift_test")
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testExec() {
        do {
            try con.exec("drop table if exists xctest")
            try con.exec("create table xctest(id INT NOT NULL AUTO_INCREMENT, val INT, PRIMARY KEY (id))")
            try con.exec("insert into xctest(val) VALUES(1)")
            XCTAssertEqual( con.affectedRows, 1)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testCreateTableObject() {

        do {
            let table = MySQL.Table(tableName: "xctest_createtable_obj", connection: con)
            try table.drop()
            
            struct obj {
                var iint8 : Int8 = -1
                var uint8: UInt8 = 1
                var int16 : Int16 = -1
                var uint16: UInt16 = 1
                var id:Int = 1
                var count:UInt = 10
                var uint64 : UInt64 = 19999999999
                var int64 : Int64 = -19999999999
                var ffloat : Float = 1.1
                var ddouble : Double = 1.1
                var ddate = Date()
                var str = "test string"
                //var ddata = "test data".dataUsingEncoding(NSUTF8StringEncoding)!
            }
            
            let o = obj()
   
            try table.create(o)

        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testCreateTableRow() {
        
        do {
            let table = MySQL.Table(tableName: "xctest_createtable_row", connection: con)
            try table.drop()
            
            let obj : MySQL.Row = [
                "oint": Int?(0) ?? 0,
                "iint8" : Int8(-1),
                "uint8": UInt8(1),
                "int16" : Int16(-1),
                "uint16": UInt16(100),
                "id":Int(1),
                "count":UInt?(10) ?? 10,
                "uint64" : UInt64(19999999999),
                "int64" : Int64(-19999999999),
                "ffloat" : Float(1.1),
                "ddouble" : Double(1.1),
                "ddate" : Date(dateString: "2015-11-10") ?? Date(),
                "str" : "test string",
                "nsdata" : "test data".data(using: String.Encoding.utf8)!,
                "uint8_array" : [UInt8]("test data uint8 array".utf8),
                //var ddata = NSData(contentsOfFile: "/Users/cipi/Pictures/team.jpg")!
            ]
            
            
            try table.create(obj)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

/*
    func testInsertTableObject() {
        
        do {
            let table = MySQL.Table(tableName: "xctest_inserttable_obj", connection: con)
            try table.drop()
            
            struct obj {
                var oint: Int? 
                var iint8 : Int8 = -1
                var uint8: UInt8 = 1
                var int16 : Int16 = -1
                var uint16: UInt16 = 100
                var id:Int = 1
                var count:UInt? = 10
                var uint64 : UInt64 = 19999999999
                var int64 : Int64 = -19999999999
                var ffloat : Float = 1.1
                var ddouble : Double = 1.1
                var ddate = Date(dateString: "2015-11-10")
                var str = "test string"
                var nsdata = "test data".data(using: String.Encoding.utf8)!
                var uint8_array = [UInt8]("test data uint8 array".utf8)
                //var ddata = NSData(contentsOfFile: "/Users/cipi/Pictures/team.jpg")!
            }
            
            let o = obj()
            
            try table.create(o)
            try table.insert(o)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
 
    func testInsertTableRow() {
        
        do {
            let table = MySQL.Table(tableName: "xctest_inserttable_row", connection: con)
            try table.drop()
            
            var obj : MySQL.Row = [
                "oint": Int?(0),
                "iint8" : Int8(-1),
                "uint8": UInt8(1),
                "int16" : Int16(-1),
                "uint16": UInt16(100),
                "id":Int(1),
                "count":UInt?(10),
                "uint64" : UInt64(19999999999),
                "int64" : Int64(-19999999999),
                "ffloat" : Float(1.1),
                "ddouble" : Double(1.1),
                "ddate" : Date(dateString: "2015-11-10"),
                "str" : "test string",
                "nsdata" : "test data".data(using: String.Encoding.utf8)!,
                "uint8_array" : [UInt8]("test data uint8 array".utf8)
                //var ddata = NSData(contentsOfFile: "/Users/cipi/Pictures/team.jpg")!
            ]
            
            
            try table.create(obj)
            obj["oint"] = NSNull()
            try table.insert(obj)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testUpdateTableRow() {
        
        do {
            let table = MySQL.Table(tableName: "xctest_updatetable_row", connection: con)
            try table.drop()
            
            var obj : MySQL.Row = [
                "oint": Int?(0),
                "iint8" : Int8(-1),
                "uint8": UInt8(1),
                "iint16" : Int16(-1),
                "uint16": UInt16(100),
                "id":Int(1),
                "iint32": 2000,
                "count":UInt?(10),
                "uint64" : UInt64(19999999999),
                "int64" : Int64(-19999999999),
                "ffloat" : Float(1.1),
                "ddouble" : Double(1.1),
                "ddate" : Date(dateString: "2015-11-10"),
                "str" : "test string",
                "nsdata" : "test data".data(using: String.Encoding.utf8)!,
                "uint8_array" : [UInt8]("test data uint8 array".utf8)
                //var ddata = NSData(contentsOfFile: "/Users/cipi/Pictures/team.jpg")!
            ]
            
            
            try table.create(obj)
            obj["oint"] = NSNull()
            try table.insert(obj)
            
            obj["iint32"] = 4000
            obj["iint16"] = Int16(-100)
            
            try table.update(obj, key: "id")
            
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testUpdateTableObject() {
        
        do {
            let table = MySQL.Table(tableName: "xctest_updatetable_obj", connection: con)
            try table.drop()
            
            struct obj {
                var oint: Int?
                var iint8 : Int8 = -1
                var uint8: UInt8 = 1
                var int16 : Int16 = -10
                var uint16: UInt16 = 100
                var iint32 : Int = -100
                var uint32 : UInt = 100
                var id:Int = 1
                var count:UInt? = 10
                var uint64 : UInt64 = 19999999999
                var int64 : Int64 = -19999999999
                var ffloat : Float = 1.1
                var ddouble : Double = 1.1
                var ddate = Date(dateString: "2015-11-10")
                var str = "test string"
                var nsdata = "test data".data(using: String.Encoding.utf8)!
                var uint8_array = [UInt8]("test data uint8 array".utf8)
            }
            
            var o = obj()
            
            try table.create(o)
            try table.insert(o)
            
            o.iint8 = -100
            o.uint8 = 100
            o.int16 = -100
            o.iint32 = -200
            //o.ddate?.dateByAddingTimeInterval(20)
            
            try table.update(o, key:"id")
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    
    func testTableSelect() {
        
        do {
            let table = MySQL.Table(tableName: "xctest_table_select", connection: con)
            try table.drop()
            
            struct obj {
                var id:Int? // = 1
                var oint: Int?
                var iint8 : Int8 = -1
                var uint8: UInt8 = 1
                var int16 : Int16 = -1
                var uint16: UInt16 = 100
                var count:UInt? = 10
                var uint64 : UInt64 = 19999999999
                var int64 : Int64 = -19999999999
                var ffloat : Float = 1.1
                var ddouble : Double = 1.1
                var ddate = Date(dateString: "2015-11-10")
                var str = "test string"
                var ddata = "test data".data(using: String.Encoding.utf8)!
                var uint8_array = [UInt8]("test data uint8 array".utf8)
                //var ddata = NSData(contentsOfFile: "/Users/cipi/Pictures/team.jpg")!
            }
            
            var o = obj()
            
            try table.create(o, primaryKey: "id", autoInc: true)
            for i in 1...100 {
                o.str = "test string \(i)"
                try table.insert(o)
            }
            
            if let row = try table.select(["str", "uint8_array"], Where: ["id=",90, "or id=",91, "or id>",95]) {
                XCTAssert(row[0].count == 7)
            }
            else {
                XCTAssert(false)
            }
            
            if let row = try table.select(["id", "str"], Where: ["str=","test string 20"]) {
                XCTAssert(row[0].count == 1)
            }
            else {
                XCTAssert(false)
            }
            
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    // Not allways success
    /*
    func testConnectionPool() {
        do {
            let connPool = try MySQL.ConnectionPool(num: 10, connection: con)
            let table = MySQL.Table(tableName: "xctest_conn_pool", connection: con)
            try table.drop()

            class obj {
                var id:Int?
                var val : Int = 1
            }
            
            let o = obj()
            try table.create(o, primaryKey: "id", autoInc: true)
            
            for i in 1...500 {
                
                DispatchQueue.global(qos: .background).async(execute: {

                    if let c = connPool.getConnection() {
                        
                        let t = MySQL.Table(tableName: "xctest_conn_pool", connection: c)
                        do {
                            let o = obj()
                            o.val = i
                            try t.insert(o)
                           
                        }
                        catch {
                            print(error)
                            XCTAssertNil(error)
                            connPool.free(c)
                            
                        }
                        connPool.free(c)
                    }
                })
            }
        }
        catch {
            XCTAssertNil(error)
        }
        sleep(2)
    }
 */
    */
    func testQuery() {
        do {
            try con.exec("drop table if exists xctest1")
            try con.exec("create table xctest1(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id))")
            let res = try con.query("select * from xctest1")
            XCTAssertNotNil(res)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRow() {
        do {
            try con.exec("drop table if exists xctest2")
            try con.exec("create table xctest2(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT)")
            try con.exec("insert into xctest2(val) VALUES(1)")
            let res = try con.query("select * from xctest2")
            let row = try res.readRow()
            XCTAssertNotNil(row)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testQueryReadRowResult() {
        do {
            try con.exec("drop table if exists xctest3")
            try con.exec("create table xctest3(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT)")
            try con.exec("insert into xctest3(val) VALUES(1)")
            let res = try con.query("select * from xctest3")
            let row = try res.readRow()
            let val = row!["val"]
            XCTAssertNotNil(val)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultInt64() {
        do {
            try con.exec("drop table if exists xctest_int64")
            try con.exec("create table xctest_int64(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val BIGINT)")
            try con.exec("insert into xctest_int64(val) VALUES(1435353345)")
            let res = try con.query("select * from xctest_int64")
            let row = try res.readRow()

            if let val = row!["val"] as? Int64, val == 1435353345 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultUInt64() {
        do {
            try con.exec("drop table if exists xctest_uint64")
            try con.exec("create table xctest_uint64(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val BIGINT UNSIGNED)")
            try con.exec("insert into xctest_uint64(val) VALUES(1)")
            let res = try con.query("select * from xctest_uint64")
            let row = try res.readRow()
            
            if let val = row!["val"] as? UInt64, val == 1 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testQueryReadRowResultInt() {
        do {
            try con.exec("drop table if exists xctest_int")
            try con.exec("create table xctest_int(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT)")
            try con.exec("insert into xctest_int(val) VALUES(1)")
            let res = try con.query("select * from xctest_int")
            let row = try res.readRow()

            if let val = row!["val"] as? Int, val == 1 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultUInt() {
        do {
            try con.exec("drop table if exists xctest_uint")
            try con.exec("create table xctest_uint(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT UNSIGNED)")
            try con.exec("insert into xctest_uint(val) VALUES(1)")
            let res = try con.query("select * from xctest_uint")
            let row = try res.readRow()

            if let val = row!["val"] as? UInt, val == 1 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultInt16() {
        do {
            try con.exec("drop table if exists xctest_int16")
            try con.exec("create table xctest_int16(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val SMALLINT)")
            try con.exec("insert into xctest_int16(val) VALUES(1)")
            let res = try con.query("select * from xctest_int16")
            let row = try res.readRow()

            if let val = row!["val"] as? Int16, val == 1 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultUInt16() {
        do {
            try con.exec("drop table if exists xctest_uint16")
            try con.exec("create table xctest_uint16(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val SMALLINT UNSIGNED)")
            try con.exec("insert into xctest_uint16(val) VALUES(1)")
            let res = try con.query("select * from xctest_uint16")
            let row = try res.readRow()

            if let val = row!["val"] as? UInt16, val == 1 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testQueryReadRowResultInt8() {
        do {
            try con.exec("drop table if exists xctest_int8")
            try con.exec("create table xctest_int8(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TINYINT)")
            try con.exec("insert into xctest_int8(val) VALUES(1)")
            let res = try con.query("select * from xctest_int8")
            let row = try res.readRow()

            if let val = row!["val"] as? Int8, val == 1 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultUInt8() {
        do {
            try con.exec("drop table if exists xctest_uint8")
            try con.exec("create table xctest_uint8(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TINYINT UNSIGNED)")
            try con.exec("insert into xctest_uint8(val) VALUES(1)")
            let res = try con.query("select * from xctest_uint8")
            let row = try res.readRow()
            
            if let val = row!["val"] as? UInt8, val == 1 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultDate() {
        do {
            try con.exec("drop table if exists xctest_date")
            try con.exec("create table xctest_date(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val DATE)")
            try con.exec("insert into xctest_date(val) VALUES('2015-12-02')")
            let res = try con.query("select * from xctest_date")
            let row = try res.readRow()

            if let val = row!["val"] as? Date, val == Date(dateString: "2015-12-02") {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testQueryReadRowResultTime() {
        do {
            try con.exec("drop table if exists xctest_time")
            try con.exec("create table xctest_time(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TIME)")
            try con.exec("insert into xctest_time(val) VALUES('12:02:24')")
            let res = try con.query("select * from xctest_time")
            let row = try res.readRow()

            if let val = row!["val"] as? Date, val == Date(timeString: "12:02:24") {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testQueryReadRowResultDateTime() {
        do {
            try con.exec("drop table if exists xctest_datetime")
            try con.exec("create table xctest_datetime(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val DATETIME)")
            try con.exec("insert into xctest_datetime(val) VALUES('2015-12-02 12:02:24')")
            let res = try con.query("select * from xctest_datetime")
            let row = try res.readRow()

            if let val = row!["val"] as? Date, val == Date(dateTimeString: "2015-12-02 12:02:24") {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testQueryReadRowResultTimeStamp() {
        do {
            try con.exec("drop table if exists xctest_timestamp")
            try con.exec("create table xctest_timestamp(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TIMESTAMP)")
            try con.exec("insert into xctest_timestamp(val) VALUES('2015-12-02 12:02:24')")
            let res = try con.query("select * from xctest_timestamp")
            let row = try res.readRow()

            if let val = row!["val"] as? Date, val == Date(dateTimeString: "2015-12-02 12:02:24") {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testQueryReadRowResultFloat() {
        do {
            try con.exec("drop table if exists xctest_float")
            try con.exec("create table xctest_float(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val FLOAT)")
            try con.exec("insert into xctest_float(val) VALUES(1.1)")
            let res = try con.query("select * from xctest_float")
            let row = try res.readRow()

            if let val = row!["val"] as? Float, val == Float(1.1) {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testQueryReadRowResultDouble() {
        do {
            try con.exec("drop table if exists xctest_double")
            try con.exec("create table xctest_double(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val DOUBLE)")
            try con.exec("insert into xctest_double(val) VALUES(1.1)")
            let res = try con.query("select * from xctest_double")
            let row = try res.readRow()

            if let val = row!["val"] as? Double, val == Double(1.1) {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }


    func testQueryReadRowResultString() {
        do {
            try con.exec("drop table if exists xctest4")
            try con.exec("create table xctest4(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val VARCHAR(5))")
            try con.exec("insert into xctest4(val) VALUES('val')")
            let res = try con.query("select * from xctest4")
            let row = try res.readRow()

            if let val = row!["val"] as? String, val=="val" {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    /// Statement tests
    
    func testStatement() {
        do {
            try con.exec("drop table if exists xctest_stmt")
            try con.exec("create table xctest_stmt(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id))")
            
            let stmt = try con.prepare("select * from xctest_stmt")
            
            XCTAssertNotNil(stmt)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRow() {
        do {
            try con.exec("drop table if exists xctest_stmt_readrow")
            try con.exec("create table xctest_stmt_readrow(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT)")
            try con.exec("insert into xctest_stmt_readrow(val) VALUES(1)")
            let stmt = try con.prepare("select * from xctest_stmt_readrow where val=?")
            let res = try stmt.query([1])
            let row = try res.readRow()

            XCTAssertNotNil(row)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    
    func testStatementReadRowResult() {
        do {
            try con.exec("drop table if exists xctest3")
            try con.exec("create table xctest3(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT)")
            try con.exec("insert into xctest3(val) VALUES(1)")
            let stmt = try con.prepare("select * from xctest3 where val=?")
            let res = try stmt.query([1])
            let row = try res.readRow()

            let val = row!["val"]
            XCTAssertNotNil(val)
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
 
    func testStatementReadRowResultInt64() {
        do {
            try con.exec("drop table if exists xctest_int64")
            try con.exec("create table xctest_int64(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val BIGINT)")
            try con.exec("insert into xctest_int64(val) VALUES(-1435353345)")
            let stmt = try con.prepare("select * from xctest_int64 where val=?")
            let res = try stmt.query([-1435353345])
            let row = try res.readRow()

            if let val = row!["val"] as? Int64, val == -1435353345 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultUInt64() {
        do {
            try con.exec("drop table if exists xctest_uint64")
            try con.exec("create table xctest_uint64(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val BIGINT UNSIGNED)")
            try con.exec("insert into xctest_uint64(val) VALUES(13423423)")
            let stmt = try con.prepare("select * from xctest_uint64 where val=?")
            let res = try stmt.query([13423423])
            let row = try res.readRow()

            if let val = row!["val"] as? UInt64, val == 13423423 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultInt() {
        do {
            try con.exec("drop table if exists xctest_int")
            try con.exec("create table xctest_int(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT)")
            try con.exec("insert into xctest_int(val) VALUES(-12345)")
            let stmt = try con.prepare("select * from xctest_int where val=?")
            let res = try stmt.query([-12345])
            let row = try res.readRow()

            if let val = row!["val"] as? Int, val == -12345 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
            
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultUInt() {
        do {
            try con.exec("drop table if exists xctest_uint")
            try con.exec("create table xctest_uint(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val INT UNSIGNED)")
            try con.exec("insert into xctest_uint(val) VALUES(12345)")
            let stmt = try con.prepare("select * from xctest_uint where val=?")
            let res = try stmt.query([12345])
            let row = try res.readRow()

            if let val = row!["val"] as? UInt, val == 12345 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
            
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultInt16() {
        do {
            try con.exec("drop table if exists xctest_stmt_int16")
            try con.exec("create table xctest_stmt_int16(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val SMALLINT)")
            try con.exec("insert into xctest_stmt_int16(val) VALUES(-12345)")
            let stmt = try con.prepare("select * from xctest_stmt_int16 where val=?")
            let res = try stmt.query([-12345])
            let row = try res.readRow()

            if let val = row!["val"] as? Int16, val == -12345 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
            
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testStatementReadRowResultUInt16() {
        do {
            try con.exec("drop table if exists xctest_stmt_uint16")
            try con.exec("create table xctest_stmt_uint16(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val SMALLINT UNSIGNED)")
            try con.exec("insert into xctest_stmt_uint16(val) VALUES(12345)")
            let stmt = try con.prepare("select * from xctest_stmt_uint16 where val=?")
            let res = try stmt.query([12345])
            let row = try res.readRow()

            if let val = row!["val"] as? UInt16, val == 12345 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultInt8() {
        do {
            try con.exec("drop table if exists xctest_stmt_int8")
            try con.exec("create table xctest_stmt_int8(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TINYINT)")
            try con.exec("insert into xctest_stmt_int8(val) VALUES(-12)")
            let stmt = try con.prepare("select * from xctest_stmt_int8 where val=?")
            let res = try stmt.query([-12])
            let row = try res.readRow()

            if let val = row!["val"] as? Int8, val == -12 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultUInt8() {
        do {
            try con.exec("drop table if exists xctest_stmt_uint8")
            try con.exec("create table xctest_stmt_uint8(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TINYINT UNSIGNED)")
            try con.exec("insert into xctest_stmt_uint8(val) VALUES(12)")
            let stmt = try con.prepare("select * from xctest_stmt_uint8 where val=?")
            let res = try stmt.query([12])
            let row = try res.readRow()

            if let val = row!["val"] as? UInt8, val == 12 {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultDate() {
        do {
            try con.exec("drop table if exists xctest_stmt_date")
            try con.exec("create table xctest_stmt_date(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val DATE)")
            try con.exec("insert into xctest_stmt_date(val) VALUES('2015-12-02')")
            let stmt = try con.prepare("select * from xctest_stmt_date where val=?")
            let res = try stmt.query(["2015-12-02"])
            let row = try res.readRow()

            if let val = row!["val"] as? Date, val == Date(dateString: "2015-12-02") {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultTime() {
        do {
            try con.exec("drop table if exists xctest_stmt_time")
            try con.exec("create table xctest_stmt_time(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TIME)")
            try con.exec("insert into xctest_stmt_time(val) VALUES('13:02:24')")
            let stmt = try con.prepare("select * from xctest_stmt_time where val=?")
            let res = try stmt.query(["13:02:24"])
            let row = try res.readRow()

            if let val = row!["val"] as? Date, val == Date(timeString: "13:02:24") {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultDateTime() {
        do {
            try con.exec("drop table if exists xctest_stmt_datetime")
            try con.exec("create table xctest_stmt_datetime(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val DATETIME, val1 DATETIME, val2 DATETIME(3), val3 TIMESTAMP(6))")
            try con.exec("insert into xctest_stmt_datetime(val, val1, val2, val3) VALUES('2015-12-02', '2015-12-02 15:02:22', '2015-12-02 14:10:12.887435', '2015-12-02 14:10:12.000435')")
            let stmt = try con.prepare("select * from xctest_stmt_datetime where val=?")
            let res = try stmt.query(["2015-12-02"])
            let row = try res.readRow()
            
            guard let val = row!["val"] as? Date, val == Date(dateString: "2015-12-02") else {
                XCTAssert(false)
                return
            }
            
            guard let val1 = row!["val1"] as? Date, val1 == Date(dateTimeString: "2015-12-02 15:02:22") else {
                XCTAssert(false)
                return
            }

            guard let val2 = row!["val2"] as? Date, val2.timeIntervalSinceReferenceDate == Date(dateTimeStringUsec: "2015-12-02 14:10:12.887435")!.timeIntervalSinceReferenceDate else {
                XCTAssert(false)
                return
            }

            guard let val3 = row!["val3"] as? Date, val3.timeIntervalSince1970 == Date(dateTimeStringUsec: "2015-12-02 14:10:12.000430")!.timeIntervalSince1970 else {
                XCTAssert(false)
                return
            }

        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultTimeStamp() {

        do {
            try con.exec("drop table if exists xctest_stmt_timestamp")
            try con.exec("create table xctest_stmt_timestamp(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val TIMESTAMP)")
            try con.exec("insert into xctest_stmt_timestamp(val) VALUES('2015-12-02 12:02:24')")
            let stmt = try con.prepare("select * from xctest_stmt_timestamp where val=?")
            let res = try stmt.query(["2015-12-02 12:02:24"])
            let row = try res.readRow()

            if let val = row!["val"] as? Date, val == Date(dateTimeString: "2015-12-02 12:02:24") {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultFloat() {
        do {

            try con.exec("drop table if exists xctest_stmt_float")
            try con.exec("create table xctest_stmt_float(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val FLOAT)")
            try con.exec("insert into xctest_stmt_float(val) VALUES(1.1)")
            let stmt = try con.prepare("select * from xctest_stmt_float where val=?")
            let res = try stmt.query([Float(1.1)])
            let row = try res.readRow()

            if let val = row!["val"] as? Float, val == Float(1.1) {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }

    func testStatementReadRowResultDouble() {
        do {
            try con.exec("drop table if exists xctest_stmt_double")
            try con.exec("create table xctest_stmt_double(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val DOUBLE)")
            try con.exec("insert into xctest_stmt_double(val) VALUES(1.1)")
            let stmt = try con.prepare("select * from xctest_stmt_double where val=?")
            let res = try stmt.query([Double(1.1)])
            let row = try res.readRow()
            
            if let val = row!["val"] as? Double, val == Double(1.1) {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    

    func testStatementReadRowResultString() {
        do {
            try con.exec("drop table if exists xctest_stmt_string")
            try con.exec("create table xctest_stmt_string(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val VARCHAR(5))")
            try con.exec("insert into xctest_stmt_string(val) VALUES('val')")
            let stmt = try con.prepare("select * from xctest_stmt_string where val=?")
            let res = try stmt.query(["val"])
            let row = try res.readRow()
            
            if let val = row!["val"] as? String, val == "val" {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }
    
    func testStatementReadRowResultUInt8Array() {
        do {
            let  data =  try! Data(contentsOf: URL(fileURLWithPath: "/Users/cipi/Pictures/team.jpg"))
            let count = data.count / MemoryLayout<UInt8>.size
            var array = [UInt8](repeating: 0, count: count)
            (data as NSData).getBytes(&array, length:count * MemoryLayout<UInt8>.size)
            
            try con.exec("drop table if exists xctest_stmt_uint8array")
            try con.exec("create table xctest_stmt_uint8array(id INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (id), val LONGBLOB)")
            var stmt = try con.prepare("insert into xctest_stmt_uint8array(val) VALUES(?)")
            try stmt.exec([array])
            
            stmt = try con.prepare("select * from xctest_stmt_uint8array where id=?")
            let res = try stmt.query([1])

            let row = try res.readRow()

            if let val = row?["val"] as? [UInt8], Mysql_SHA1(val).equals(Mysql_SHA1(array))  {
                XCTAssert(true)
            }
            else {
                XCTAssert(false)
            }
        }
        catch(let e) {
            XCTAssertNil(e)
        }
    }


   
}
