const express = require('express');
const cors = require('cors');
const mysql = require('mysql');
const app = express();
const multer = require('multer');
const path = require('path');
// Enable CORS
app.use(cors());
app.use(express.json());

const connection = mysql.createConnection({
    host: 'localhost',  // here is localhost
    user: 'root',        // username
    password: '', // having password 
    database: 'mylogin' // db name
});

// make an connection with sql

connection.connect(err => {
    if (err) {
        console.error('Error connecting to MySQL:', err.stack);
    } else {
        console.log('Connected to MySQL as id', connection.threadId);
    }
});

// write query for insert data 

app.post('/insert', (req, res) => {
    const { email, password } = req.body;
    const sqlQuery = 'INSERT INTO user (email, password) VALUES (?, ?)';
    connection.query(sqlQuery, [email, password], (err, result) => {
        if (err) {
            console.error('Error inserting data:', err);
            return res.status(500).send('Error inserting data');
        }
        res.status(200).send(`Data inserted, ID: ${result.insertId}`);
    });
});

// write query for get data 

app.get('/getbrand', async (req, res) => {
    try {
        const sqlQuery = 'SELECT * FROM `brand`';

        // Use a Promise-based approach for query execution
        connection.query(sqlQuery, [], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }
            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});
// Dropdown values 
app.get('/companies', async (req, res) => {
    try {
        const sqlQuery = 'SELECT * FROM `section`';

        // Use a Promise-based approach for query execution
        connection.query(sqlQuery, [], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }
            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});


// write an query for post data 

app.post('/modelfetch', async (req, res) => {
    try {
        const { id } = req.body;

        // Validate the input
        if (!id) {
            return res.status(400).send('Brand ID is required');
        }

        const sqlQuery = 'SELECT * FROM `model` WHERE `brandId` = ?';

        // Use a Promise-based approach for query execution
        connection.query(sqlQuery, [id], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }

            // Send the result back as a response
            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});

// write an query for Register data into SQL

const bcrypt = require('bcrypt');
const { promisify } = require('util');
const saltRounds = 10;

// Define globals object
const globals = {
    message: "",
    success: true,
    userList: null,
};

const queryAsync = promisify(connection.query).bind(connection);

app.post('/registeruser', async (req, res) => {
    const { portalUsername, password, cnic, fullName, phone, landline, email, dob, address, gender, companyName, companyID } = req.body;

    try {
        globals.message = "";
        globals.success = true;
        globals.userList = null;

        if (!portalUsername || !password) {
            globals.message = "Missing required fields";
            globals.success = false;
            return res.status(400).json({ error: globals.message });
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        // Prepare the SQL query
        const sqlQuery = `INSERT INTO usermotor (portalUsername, password, cnic, fullName, phone, landline, email, dob, address, gender, companyName, companyID) 
                          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

        // Execute the query using async/await
        const result = await queryAsync(sqlQuery, [
            portalUsername,
            hashedPassword,
            cnic,
            fullName,
            phone,
            landline,
            email,
            dob,
            address,
            gender,
            companyName,
            companyID
        ]);

        // Update global variables on success
        globals.message = `Data inserted successfully, ID: ${result.insertId}`;
        globals.userList = result;
        res.status(200).json({ message: globals.message });

    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            globals.message = 'Duplicate entry, the user already exists';
            globals.success = false;
            return res.status(409).json({ error: globals.message });
        }

        globals.message = 'Internal Server Error';
        globals.success = false;
        console.error('Error during user registration:', error);
        res.status(500).json({ error: globals.message });
    }
});



// Login API (GET request)


//-------------------- Login API (GET request) -----------------------------//

app.get('/loginind', async (req, res) => {
    const { phone, password, companyID } = req.query;

    console.log("Received phone:", phone);
    console.log("Received password:", password);
    console.log("Received companyid:", companyID);

    try {
        // Check for missing fields
        if (!phone || !password || !companyID) {
            return res.status(400).json({
                success: false,
                message: "Phone, password, or company ID missing",
            });
        }

        // Query to get user data based on phone and companyID
        const sqlQuery = `SELECT * FROM usermotor WHERE phone = ? AND companyID = ?`;
        const userResult = await queryAsync(sqlQuery, [phone, companyID]);

        // If no user found, send failure response
        if (userResult.length === 0) {
            return res.status(404).json({
                success: false,
                message: "User not found or company ID mismatch",
            });
        }

        const user = userResult[0];

        // Compare password with the stored hashed password
        const isMatch = await bcrypt.compare(password, user.password);

        // If password does not match, send failure response
        if (!isMatch) {
            return res.status(401).json({
                success: false,
                message: "Incorrect password",
            });
        }

        // On success, return user data in structured format
        return res.status(200).json({
            success: true,
            message: "Login Successfully",
            Data: {
                UserID: user.id,
                PortalUsername: user.portalUsername,
                FullName: user.fullName,
                Email: user.email,
                Address1: user.address,
                Phone: user.phone,
                Gender: user.gender,
                Landline: user.landline,
                DOB: user.dob,
                CompanyID: user.companyID,
                Company: user.companyName,

            }
        });

    } catch (error) {
        console.error("Login error:", error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error",
        });
    }
});
app.get('/logincop', async (req, res) => {
    const { portalUsername, password, companyID } = req.query;

    console.log("Received portalUsername:", portalUsername);
    console.log("Received password:", password);
    console.log("Received companyid:", companyID);

    try {
        // Check for missing fields
        if (!portalUsername || !password || !companyID) {
            return res.status(400).json({
                success: false,
                message: "PortalUsername, password, or company ID missing",
            });
        }

        // Query to get user data based on phone and companyID
        const sqlQuery = `SELECT * FROM usermotor WHERE portalUsername = ? AND companyID = ?`;
        const userResult = await queryAsync(sqlQuery, [portalUsername, companyID]);

        // If no user found, send failure response
        if (userResult.length === 0) {
            return res.status(404).json({
                success: false,
                message: "User not found or company ID mismatch",
            });
        }

        const user = userResult[0];

        // Compare password with the stored hashed password
        const isMatch = await bcrypt.compare(password, user.password);

        // If password does not match, send failure response
        if (!isMatch) {
            return res.status(401).json({
                success: false,
                message: "Incorrect password",
            });
        }

        // On success, return user data in structured format
        return res.status(200).json({
            success: true,
            message: "Login Successfully",
            Data: {
                UserID: user.id,
                PortalUsername: user.portalUsername,
                FullName: user.fullName,
                Email: user.email,
                Address1: user.address,
                Phone: user.phone,
                Gender: user.gender,
                Landline: user.landline,
                DOB: user.dob,
                CompanyID: user.companyID,
                Company: user.companyName,

            }
        });

    } catch (error) {
        console.error("Login error:", error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error",
        });
    }
});
// -------------  upate the profile user ------------------- //
app.post('/updateUser', async (req, res) => {
    const { userID, phone, email, password } = req.body;

    try {
        // Validate required fields
        if (!userID) {
            return res.status(400).json({ success: false, message: "User ID is required" });
        }

        // Build the update query dynamically
        let updates = [];
        let queryParams = [];

        // Check which fields are provided and add them to the update query
        if (phone) {
            updates.push('phone = ?');
            queryParams.push(phone);
        }

        if (email) {
            updates.push('email = ?');
            queryParams.push(email);
        }

        if (password) {
            const hashedPassword = await bcrypt.hash(password, saltRounds); // Hash the new password
            updates.push('password = ?');
            queryParams.push(hashedPassword);
        }

        // If no updates were provided
        if (updates.length === 0) {
            return res.status(400).json({ success: false, message: "No fields to update" });
        }

        // Prepare the SQL query dynamically based on the fields to update
        const sqlQuery = `UPDATE usermotor SET ${updates.join(', ')} WHERE userID = ?`;
        queryParams.push(userID); // Add userID to the query params for WHERE clause

        // Execute the query using async/await
        const result = await queryAsync(sqlQuery, queryParams);

        // Check if any rows were updated
        if (result.affectedRows === 0) {
            return res.status(404).json({ success: false, message: "User not found" });
        }

        // Success response
        res.status(200).json({ success: true, message: "User information updated successfully" });

    } catch (error) {
        console.error("Error updating user information:", error);
        res.status(500).json({ success: false, message: "Internal Server Error" });
    }
});
// ---------------------  Insert Data Query  ------------------------------  //
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'upload/'); // Define your upload directory
    },
    filename: function (req, file, cb) {
        const uniqueName = Date.now() + '-' + file.originalname; // Unique filename
        cb(null, uniqueName);
    }
});

const upload = multer({ storage: storage });

// Update your route to handle image upload
app.post('/registerVehicle', upload.fields([{ name: 'cnicFrontImage' }, { name: 'cnicBackImage' }]), async (req, res) => {
    const {
        brand,
        model,
        registerNo,
        chasiNo,
        cnic,
        engineNo,
        address,
        yearManufacture,
        remarks,
        startDate,
        endDate,
        userID,
        insuranceID,
        insuranceName,
        policyID,
        userStatus
    } = req.body;

    const cnicFrontImageUrl = req.files['cnicFrontImage'] ? req.files['cnicFrontImage'][0].path : null;
    const cnicBackImageUrl = req.files['cnicBackImage'] ? req.files['cnicBackImage'][0].path : null;

    try {
        globals.message = "";
        globals.success = true;

        // Ensure all required fields are provided
        if (!userID) {
            globals.message = "Missing required fields";
            globals.success = false;
            return res.status(400).json({ error: globals.message });
        }
        if (globals.success = true) {
            const sqlQuery = `
        INSERT INTO motorinsurance
        (brand, model, registerNo, chasiNo, cnic, engineNo, address, yearManufacture, remarks, startDate, endDate, cnicFrontImageUrl, cnicBackImageUrl, userID, insuranceID, insuranceName,policyID, userStatus)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)`;
            const result = await queryAsync(sqlQuery, [
                brand,
                model,
                registerNo,
                chasiNo,
                cnic,
                engineNo,
                address,
                yearManufacture,
                remarks,
                startDate,
                endDate,
                cnicFrontImageUrl,
                cnicBackImageUrl,
                userID,
                insuranceID,
                insuranceName,
                policyID,
                userStatus
            ]);
            console.log("Error Result :", result);

            globals.message = `Vehicle registered successfully, ID: ${result.insertId}`;
        }


        res.status(200).json({ success: globals.success, message: globals.message });

    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            globals.message = 'Duplicate entry, the vehicle already exists';
            globals.success = false;
            return res.status(409).json({ error: globals.message });
        }

        globals.message = 'Internal Server Error';
        globals.success = false;
        console.error('Error during vehicle registration:', error);
        res.status(500).json({ error: globals.message });
    }
});
// travelling insurance
app.post('/travellingInsurance', upload.fields([{ name: 'cnicFrontImage' }, { name: 'cnicBackImage' }]), async (req, res) => {
    const {
        from,
        to,
        startDate,
        endDate,
        cnic,
        address,
        passportNo,
        remarks,
        userID,
        insuranceID,
        insuranceName,
        policyID,
        userStatus
    } = req.body;
    const cnicFrontImageUrl = req.files['cnicFrontImage'] ? req.files['cnicFrontImage'][0].path : null;
    const cnicBackImageUrl = req.files['cnicBackImage'] ? req.files['cnicBackImage'][0].path : null;
    try {
        globals.message = "";
        globals.success = true;
        // Ensure all required fields are provided
        if (!userID) {
            globals.message = "Missing required fields";
            globals.success = false;
            return res.status(400).json({ error: globals.message });
        }
        if (globals.success = true) {
            const sqlQuery = `
            INSERT INTO travellinginsurance
            (\`from\`, \`to\`, startDate, endDate, cnic, address, passportNo, remarks, cnicFrontImageUrl, cnicBackImageUrl, userID, insuranceID, insuranceName, policyID, userStatus)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`;
            const result = await queryAsync(sqlQuery, [
                from,
                to,
                startDate,
                endDate,
                cnic,
                address,
                passportNo,
                remarks,
                cnicFrontImageUrl,
                cnicBackImageUrl,
                userID,
                insuranceID,
                insuranceName,
                policyID,
                userStatus
            ]);
            console.log("Error Result :", result);
            globals.message = `Vehicle registered successfully, ID: ${result.insertId}`;
        }
        res.status(200).json({ success: globals.success, message: globals.message });
    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            globals.message = 'Duplicate entry, the vehicle already exists';
            globals.success = false;
            return res.status(409).json({ error: globals.message });
        }
        globals.message = 'Internal Server Error';
        globals.success = false;
        console.error('Error during vehicle registration:', error);
        res.status(500).json({ error: globals.message });
    }
});
// Start the server on port 3000
app.post('/adimreg', async (req, res) => {
    const { fullName, email, password, type } = req.body;

    try {
        globals.message = "";
        globals.success = true;
        globals.userList = null;

        if (!fullName || !password) {
            globals.message = "Missing required fields";
            globals.success = false;
            return res.status(400).json({ error: globals.message });
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        // Prepare the SQL query, using the hashed password
        const sqlQuery = `INSERT INTO admin (name, email, password, type) 
                          VALUES (?, ?, ?, ?)`;

        // Execute the query using async/await with the hashed password
        const result = await queryAsync(sqlQuery, [
            fullName,
            email,
            hashedPassword,  // Use the hashed password here
            type,
        ]);

        // Update global variables on success
        globals.message = `Data inserted successfully, ID: ${result.insertId}`;
        globals.userList = result;
        res.status(200).json({ message: globals.message });

    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            globals.message = 'Duplicate entry, the user already exists';
            globals.success = false;
            return res.status(409).json({ error: globals.message });
        }

        globals.message = 'Internal Server Error';
        globals.success = false;
        console.error('Error during user registration:', error);
        res.status(500).json({ error: globals.message });
    }
});

/// -----------------------   Admin Login Query -----------------------///
app.get('/admin', async (req, res) => {
    const { name, password } = req.query;

    console.log("Received portalUsername:", name);
    console.log("Received password:", password);

    try {
        // Check for missing fields
        if (!name || !password) {
            return res.status(400).json({
                success: false,
                message: "PortalUsername or password missing",
            });
        }

        // Query to get user data based on name
        const sqlQuery = `SELECT * FROM admin WHERE name = ?`;
        const userResult = await queryAsync(sqlQuery, [name]);

        // If no user found, send failure response
        if (userResult.length === 0) {
            return res.status(404).json({
                success: false,
                message: "User not found",
            });
        }

        const user = userResult[0];

        // Compare plain text password with the stored hashed password
        const isMatch = await bcrypt.compare(password, user.password);

        // If password does not match, send failure response
        if (!isMatch) {
            return res.status(401).json({
                success: false,
                message: "Incorrect password",
            });
        }

        // On success, return user data in structured format
        return res.status(200).json({
            success: true,
            message: "Login Successfully",
            Data: {
                UserID: user.id,
                FullName: user.name,
                Email: user.email,
                Password: user.password, // Best practice is not to return the password
            }
        });

    } catch (error) {
        console.error("Login error:", error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error",
        });
    }
});
// --------------------   All User Get Info --------------------- //
app.get('/allinsuranceuser', async (req, res) => {
    try {
        const sqlQuery = `
            SELECT 
                m.userID,
                m.insuranceName,
                m.insuranceID,
                m.userStatus,
                m.policyID,
                u.fullName,
                u.email, 
                u.phone 
            FROM 
                motorinsurance m
            LEFT OUTER JOIN 
                usermotor u
            ON 
                m.userID = u.id
            UNION          
            SELECT 
                t.userID,
                t.insuranceName,
                t.insuranceID,
                t.userStatus,
                t.policyID,
                u.fullName,
                u.email, 
                u.phone 
            FROM 
                travellinginsurance t
            LEFT OUTER JOIN 
                usermotor u
            ON 
                t.userID = u.id;
        `;

        connection.query(sqlQuery, [], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }
            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});

///-------------------------  User insurance Status Update -----------------  ///


app.post('/updatestatus', async (req, res) => {
    const { user_ID, insurance_ID, insuranceName, status } = req.body;

    console.log("Received userID:", user_ID);
    console.log("Received insuranceID:", insurance_ID);
    console.log("Received insuranceName:", insuranceName);
    console.log("Received status:", status);

    try {
        // Clear global variables
        globals.message = "";
        globals.success = true;

        // Validate required fields
        if (!user_ID || !insurance_ID || !insuranceName || !status) {
            globals.message = "Missing required fields: userID, insurance_ID, insuranceName, or status";
            globals.success = false;
            return res.status(400).json({ error: globals.message });
        }

        // Prepare the SQL query to insert or update status
        const sqlQuery = `
            INSERT INTO status (user_ID, insurance_ID, insuranceName, status)
            VALUES (?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE status = ?;
        `;

        // Execute the query using async/await, passing status twice (once for the insert, once for update)
        const result = await queryAsync(sqlQuery, [user_ID, insurance_ID, insuranceName, status, status]);

        // Update globals and send success message
        globals.message = `Status updated successfully for userID: ${user_ID}`;
        res.status(200).json({ message: globals.message });

    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            globals.message = 'Duplicate entry, status already exists for this user';
            globals.success = false;
            return res.status(409).json({ error: globals.message });
        }

        globals.message = 'Internal Server Error';
        globals.success = false;
        console.error('Error updating status:', error);
        res.status(500).json({ error: globals.message });
    }
});



/// --------------------------  User Status values -----------------------------///
app.get('/getstatus', async (req, res) => {
    try {
        // SQL query to get all data from the 'status' table
        const sqlQuery = `SELECT * FROM status`;

        // Execute the query using async/await
        const statusResult = await queryAsync(sqlQuery);

        // If no data is found in the 'status' table, return a 404 response
        if (statusResult.length === 0) {
            return res.status(404).json({
                success: false,
                message: "No data found in the status table",
            });
        }

        // On success, return the status data
        return res.status(200).json({
            success: true,
            message: "Data fetched successfully",
            data: statusResult
        });

    } catch (error) {
        console.error("Error fetching status data:", error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error",
        });
    }
});
/// -------------------------   user of status  --------------------------------///
app.get('/allmotoruserstatus', async (req, res) => {
    try {
        // SQL query to fetch only users who have a status
        const sqlQuery = `
          SELECT
    u.id AS userID,
    u.fullName,
    u.email,
    u.phone,
    m.insuranceName,
    m.policyID,
    m.userStatus
FROM
    usermotor u
INNER JOIN
    motorinsurance m
ON
    u.id = m.userID;

        `;

        // Execute the SQL query
        connection.query(sqlQuery, [], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }
            // Send the result as a JSON response
            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});

app.get('/travelledstatus', async (req, res) => {
    try {
        // SQL query to fetch only users who have a status
        const sqlQuery = `
          SELECT u.id AS userID, u.fullName, u.email, u.phone, t.insuranceName, t.policyID, t.userStatus FROM usermotor u INNER JOIN travellinginsurance t ON u.id = t.userID;`;

        // Execute the SQL query
        connection.query(sqlQuery, [], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }
            // Send the result as a JSON response
            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});
// -------------------------- insurance list get ----------------------- ///
app.get('/getinsurance', async (req, res) => {
    try {
        const sqlQuery = 'SELECT * FROM `insurance`';

        // Use a Promise-based approach for query execution
        connection.query(sqlQuery, [], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }
            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});

/// ------------------------------  My Policies --------------------------///
app.get('/userinsurancepolicies', async (req, res) => {
    const userID = req.query.userID;

    try {
        const sqlQuery = `
            SELECT 
                m.insuranceName, 
                m.userStatus
            FROM 
                motorinsurance m
            WHERE 
                userID = ?

            UNION ALL

            SELECT 
                t.insuranceName, 
                t.userStatus
            FROM 
                travellinginsurance t
            WHERE 
                userID = ?;
        `;

        connection.query(sqlQuery, [userID, userID], (err, results) => {
            if (err) {
                console.error('Error fetching insurance policies:', err);
                return res.status(500).send('Error fetching data');
            }
            res.status(200).json(results);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        res.status(500).send('Internal Server Error');
    }
});
/// ------------------------------- Update the POlicies Motor Status -------------///
app.post('/motorstatus', async (req, res) => {
    const { userID, policyID, userStatus } = req.body;
    try {
        globals.message = "";
        globals.success = true;

        // Ensure all required fields are provided
        if (!userID || !policyID || !userStatus) {
            globals.message = "Missing required fields: userID, policyID, or userStatus";
            globals.success = false;
            return res.status(400).json({ error: globals.message });
        }

        // Check both tables for the policyID
        const checkQuery = `
            SELECT 
                (SELECT COUNT(*) FROM motorinsurance WHERE userID = ? AND policyID = ?) AS motorCount,
                (SELECT COUNT(*) FROM travellinginsurance WHERE userID = ? AND policyID = ?) AS travelCount;
        `;
        const counts = await queryAsync(checkQuery, [userID, policyID, userID, policyID]);

        const motorCount = counts[0].motorCount;
        const travelCount = counts[0].travelCount;

        // If the policyID exists in motorinsurance
        if (motorCount > 0) {
            const updateMotorQuery = `
                UPDATE motorinsurance
                SET userStatus = ?
                WHERE userID = ? AND policyID = ?;
            `;
            await queryAsync(updateMotorQuery, [userStatus, userID, policyID]);
            globals.message = `Status successfully updated in motorinsurance for userID: ${userID}`;
        }
        // If the policyID exists in travellinginsurance
        else if (travelCount > 0) {
            const updateTravelQuery = `
                UPDATE travellinginsurance
                SET userStatus = ?
                WHERE userID = ? AND policyID = ?;
            `;
            await queryAsync(updateTravelQuery, [userStatus, userID, policyID]);
            globals.message = `Status successfully updated in travellinginsurance for userID: ${userID}`;
        }
        // If the policyID does not exist in either table
        else {
            globals.message = 'No matching policyID found in both motorinsurance and travellinginsurance.';
            globals.success = false;
            return res.status(404).json({ error: globals.message });
        }

        res.status(200).json({ success: globals.success, message: globals.message });

    } catch (error) {
        // Handle duplicate entry error specifically
        if (error.code === 'ER_DUP_ENTRY') {
            globals.message = 'Duplicate entry, the userID already exists';
            globals.success = false;
            return res.status(409).json({ error: globals.message });
        }

        // General error handling
        globals.message = 'Internal Server Error';
        globals.success = false;
        console.error('Error during status update:', error);
        res.status(500).json({ error: globals.message });
    }
});
/// -----------------  Delete Try ------------------------------ ///

app.post('/deletepolicy', async (req, res) => {
    const { userID, policyID } = req.body;
    try {
        globals.message = "";
        globals.success = true;

        // Ensure all required fields are provided
        if (!userID || !policyID) {
            globals.message = "Missing required fields: userID, policyID.";
            globals.success = false;
            return res.status(400).json({ error: globals.message });
        }

        // Check if the policy exists in motorinsurance
        const motorCheckQuery = `
            SELECT * FROM motorinsurance
            WHERE userID = ? AND policyID = ?;
        `;
        const motorResult = await queryAsync(motorCheckQuery, [userID, policyID]);

        // Check if the policy exists in travellinginsurance
        const travelCheckQuery = `
            SELECT * FROM travellinginsurance
            WHERE userID = ? AND policyID = ?;
        `;
        const travelResult = await queryAsync(travelCheckQuery, [userID, policyID]);

        // Determine where to delete from based on existence
        if (motorResult.length > 0) {
            const deleteMotorQuery = `
                DELETE FROM motorinsurance 
                WHERE userID = ? AND policyID = ?;
            `;
            await queryAsync(deleteMotorQuery, [userID, policyID]);
            return res.json({ message: 'Policy for user deleted successfully from motorinsurance' });
        } else if (travelResult.length > 0) {
            const deleteTravelQuery = `
                DELETE FROM travellinginsurance 
                WHERE userID = ? AND policyID = ?;
            `;
            await queryAsync(deleteTravelQuery, [userID, policyID]);
            return res.json({ message: 'Policy for user deleted successfully from travellinginsurance' });
        } else {
            // If the policy doesn't exist in either table, return a 404
            return res.status(404).json({ error: 'Policy not found for the user in both tables' });
        }

    } catch (error) {
        // Handle duplicate entry error specifically
        if (error.code === 'ER_DUP_ENTRY') {
            globals.message = 'Duplicate entry, the userID already exists';
            globals.success = false;
            return res.status(409).json({ error: globals.message });
        }

        // General error handling
        globals.message = 'Internal Server Error';
        globals.success = false;
        console.error('Error during policy deletion:', error);
        res.status(500).json({ error: globals.message });
    }
});

// ------------------------------ Send Message To Admin --------------------------------//
app.post('/sendMessage', async (req, res) => {
    const { userId, isAdmin, message } = req.body;

    try {
        // Validate required fields
        if (!userId || !isAdmin, !message) {
            return res.status(400).json({ error: "Missing required fields" });
        }

        // SQL query to insert a message into the chat table
        const sqlQuery = `
            INSERT INTO admin_chat (user_id, isAdmin, message)
            VALUES (?, ?, ?)
        `;

        // Execute the query
        const result = await queryAsync(sqlQuery, [userId, isAdmin, message]);

        // Respond with success message and the new message ID
        res.status(200).json({ message: "Message sent successfully", messageId: result.insertId });

    } catch (error) {
        console.error("Error inserting chat message:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});
// -----------------------  Received Message  --------------------------------///
app.get('/getMessage', async (req, res) => {
    const userId = req.query.userId; // Assuming the user ID is sent as a query parameter

    if (!userId) {
        return res.status(400).send('User ID is required');
    }

    try {
        // Use a parameterized query to prevent SQL injection
        const sqlQuery = 'SELECT * FROM `admin_chat` WHERE `user_id` = ?';

        connection.query(sqlQuery, [userId], (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }

            // Check if any messages were found
            if (result.length === 0) {
                return res.status(404).send('No messages found for this user');
            }

            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});

app.get('/getUserNotification', async (req, res) => {
    try {
        // SQL query to get unique user IDs from admin_chat and join with user names from usermotor table
        const sqlQuery = `
            SELECT ac.user_id, um.fullName FROM admin_chat ac INNER JOIN usermotor um ON ac.user_id = um.id GROUP BY ac.user_id;`;

        connection.query(sqlQuery, (err, result) => {
            if (err) {
                console.error('Error fetching data:', err);
                return res.status(500).send('Error fetching data');
            }

            if (result.length === 0) {
                return res.status(404).send('No records found');
            }

            res.status(200).json(result);
        });

    } catch (error) {
        console.error('Unexpected error:', error);
        return res.status(500).send('Internal Server Error');
    }
});


const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on http://127.0.0.1:${port}`);
});
