*** Settings *** 
Library    AppiumLibrary
Library   ExcelLibrary
Library	  Collections
Library    ScreenCapLibrary
Library    openpyxl
Resource    ../resource/RS_AndroidConfig.robot

*** Variables ***
${vbc_manu}    xpath=//android.widget.Button[@index='0']
${vbc_manu2}    xpath=//android.view.View[@index='1']
${vbc_emp}    xpath=//android.widget.RadioButton[@index='4']
${vb_us}    xpath=//android.widget.EditText[@text='ชื่อผู้ใช้']
${vb_pw}    xpath=//android.widget.EditText[@text='รหัสผ่าน']
${vb_login}    xpath=//android.view.View[@content-desc="เข้าสู่ระบบ"]
${vb_BT}    xpath=//android.widget.Button[@content-desc="เพิ่มข้อมูล"]

${vb_cid}    xpath=//android.widget.EditText[@text="หมายเลขประจำตัวโค"]
${vb_cname}    xpath=//android.widget.EditText[@text="ชื่อโค"]

${sn_Gander}    xpath=//android.widget.Button[@index='6']
${sn_gf}    xpath=//android.view.View[@content-desc="ผู ้"]
${sn_gm}    xpath=//android.view.View[@content-desc="เมีย"]

${vb_Weight}    xpath=//android.widget.EditText[@text="น้ำหนัก (กิโลกรัม)"]
${vb_Height}    xpath=//android.widget.EditText[@text="ส่วนสูง (เซนติเมตร)"]

${sn_color}    xpath=//android.widget.Button[@content-desc="สี"]
${sn_clr}    xpath=//android.view.View[@content-desc="ดำ"]
${sn_clb}    xpath=//android.view.View[@content-desc="แดง"]

${sn_Species}    xpath=//android.widget.Button[@content-desc="พันธุ์"]
${sn_sc1}    xpath=//android.view.View[@content-desc="Beefmaster"]
${sn_sc2}    xpath=//android.view.View[@content-desc="brahman"]
${sn_sc3}    xpath=//android.view.View[@content-desc="Brangus"]
${sn_sc4}    xpath=//android.view.View[@content-desc="Gyr"]
${sn_sc5}    xpath=	//android.view.View[@content-desc="Wagyu"]


${sn_Country}    xpath=//android.widget.Button[@content-desc="ประเทศ"]
${sn_ct1}    xpath=//android.view.View[@content-desc="Australia"]
${sn_ct2}    xpath=//android.view.View[@content-desc="New Zealand"]
${sn_ct3}    xpath=//android.view.View[@content-desc="South Africa"]
${sn_ct4}    xpath=//android.view.View[@content-desc="Namibia"]    
${sn_ct5}    xpath=//android.view.View[@content-desc="United Kingdom"]
${sn_ct6}    xpath=//android.view.View[@content-desc="Canada"]
${sn_ct7}    xpath=//android.view.View[@content-desc="USA"]
${sn_ct8}    xpath=//android.view.View[@content-desc="Argentina"]

# ${sn_Cf}    xpath=//android.widget.Button[@content-desc="หมายเลขประจำตัวแม่พันธุ์"]
# ${sn_Cf}    xpath=//android.widget.Button[@content-desc="หมายเลขประจำตัวแม่พันธุ์"]


${sn_Cm}    xpath=//android.widget.Button[@content-desc="หมายเลขประจำตัวพ่อพันธุ์"]

${testcaseData} 
${Status} 

*** Test Cases ***
TC03_RegisterCow
    # Start Video Recording    name=D:/robot_pjtest/results/TC03_RegisterCow/video/TC03_RegisterCow  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC03_RegisterCow.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
            Open Test Application
            LoginPage
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}
            ${cid}     Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
            ${CName}     Set Variable if    '${excel.cell(${i},4).value}'=='None'    ${Empty}     ${excel.cell(${i},4).value}  
            # ${BD}     Set Variable if    '${excel.cell(${i},5).value}'=='None'    ${Empty}     ${excel.cell(${i},5).value}
            ${gd}     Set Variable if    '${excel.cell(${i},6).value}'=='None'    ${Empty}     ${excel.cell(${i},6).value}
            ${weight}     Set Variable if    '${excel.cell(${i},7).value}'=='None'    ${Empty}     ${excel.cell(${i},7).value}
            ${height}     Set Variable if    '${excel.cell(${i},8).value}'=='None'    ${Empty}     ${excel.cell(${i},8).value} 
            # ${Picture}     Set Variable if    '${excel.cell(${i},9).value}'=='None'    ${Empty}     ${excel.cell(${i},9).value}
            # ${ck}     Set Variable if    '${excel.cell(${i},10).value}'=='None'    ${Empty}     ${excel.cell(${i},10).value}
            ${color}     Set Variable if    '${excel.cell(${i},11).value}'=='None'    ${Empty}     ${excel.cell(${i},11).value}
            ${species}     Set Variable if    '${excel.cell(${i},12).value}'=='None'    ${Empty}     ${excel.cell(${i},12).value}
            ${country}     Set Variable if    '${excel.cell(${i},13).value}'=='None'    ${Empty}     ${excel.cell(${i},13).value}
            # ${MB}     Set Variable if    '${excel.cell(${i},14).value}'=='None'    ${Empty}     ${excel.cell(${i},14).value}
            # ${FB}     Set Variable if    '${excel.cell(${i},15).value}'=='None'    ${Empty}     ${excel.cell(${i},15).value}
            
            Input id name    ${cid}    ${CName}
            Gender    ${gd}
            Input W_Height    ${weight}     ${height}
            Swipe By Percent	50	90	50	20	4000
            Color    ${color}
            Species    ${species} 
            Country    ${country}    
# เช็ค Error
        #     KeyInformation    ${user}    ${pass}
        #     ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}    Check Error page    ${excel.cell(${i},16).value}
        #     ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
        #     Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC03_RegisterCow/Screenshot/${tcid}.png
        #     ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}


        #     ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
        #     ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},16).value}"


        #     Write Excel Cell        ${i}    17       value=${get_message}       sheet_name=TestData
        #     Write Excel Cell        ${i}    18       value=${Status}           sheet_name=TestData
        #     Write Excel Cell        ${i}    19       value=${Error}        sheet_name=TestData
        #     Write Excel Cell        ${i}    20       value=${Suggestion}        sheet_name=TestData
             
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC03_RegisterCow//WriteExcel//TC03_RegisterCow_Result.xlsx
    Close All Excel Documents
    Close Application
    # Stop Video Recording      alias=None

*** Keywords ***
Open Test Application
  Open Application  http://localhost:4723/wd/hub  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
  ...  app=${ANDROID_APP}  appPackage=com.example.cow_mange    appActivity=.MainActivity

LoginPage 
    Click Element    ${vbc_manu}
    Click Element    ${vbc_manu2}
    Click Element    ${vbc_emp}
    Click Element    ${vb_us}  
    Input Text  ${vb_us}    user02
    Click Element    ${vb_pw}
    Input Text  ${vb_pw}    123456
    Click Element  ${vb_login}
    Wait Until Page Contains Element  ${vb_BT}   5s
    Click Element    ${vb_BT}

Input id name
    [Arguments]    ${CID}    ${CNAME}
    Click Element    ${vb_cid}
    Input Text    ${vb_cid}    ${CID}    
    Click Element    ${vb_cname}
    Input Text    ${vb_cname}    ${cname}

Gender
    [Arguments]  ${gander}

    Wait Until Page Contains Element  ${sn_Gander}   10s
     Click Element    ${sn_Gander}
    IF    '${gander}' == 'ผู้' 
        Wait Until Page Contains Element    ${sn_gf}    10s
        Click Element    ${sn_gf}
        Sleep    1s
    ELSE IF  '${gander}' == 'เมีย' 
        Wait Until Page Contains Element    ${sn_gm}   10s
        Click Element    ${sn_gm}
        Sleep    1s
    END

Input W_Height
    [Arguments]    ${Weight}     ${Height} 
    Click Element    ${vb_Weight}
    Input Text    ${vb_Weight}    ${weight}
    Click Element    ${vb_Height}
    Input Text    ${vb_Height}    ${height}

#ผู้ดูแลโค
# Cow keeper
# # เลือกกับไม่เลือก
#     [Arguments]  ${CK}

#     Wait Until Page Contains Element  ${sn_Gander}   10s
#      Click Element    ${sn_Gander}
#     IF    '${ck}' == 'ผู้' 
#         Wait Until Page Contains Element    ${sn_gf}    10s
#         Click Element    ${sn_gf}
#         Sleep    1s
#     ELSE IF  '${ck}' == 'เมีย' 
#         Wait Until Page Contains Element    ${sn_gm}   10s
#         Click Element    ${sn_gm}
#         Sleep    1s
#     END

Color
    [Arguments]  ${Color}

    Wait Until Page Contains Element  ${sn_color}   10s
     Click Element    ${sn_color}
    IF    '${color}' == 'ดำ' 
        Wait Until Page Contains Element    ${sn_clr}    10s
        Click Element    ${sn_clr}
        Sleep    1s
    ELSE IF  '${color}' == 'แดง' 
        Wait Until Page Contains Element    ${sn_clb}   10s
        Click Element    ${sn_clb}
        Sleep    1s
    END

Species
    [Arguments]  ${Species}

    Wait Until Page Contains Element  ${sn_Species}   10s
     Click Element    ${sn_Species}
    IF    '${species}' == 'Beefmaster' 
        Wait Until Page Contains Element    ${sn_sc1}    10s
        Click Element    ${sn_sc1}
        Sleep    1s
    ELSE IF  '${species}' == 'brahman' 
        Wait Until Page Contains Element    ${sn_sc2}   10s
        Click Element    ${sn_sc2}
        Sleep    1s
    ELSE IF  '${species}' == 'Brangus' 
        Wait Until Page Contains Element    ${sn_sc3}   10s
        Click Element    ${sn_sc3}
        Sleep    1s
    ELSE IF  '${species}' == 'Gyr' 
        Wait Until Page Contains Element    ${sn_sc4}   10s
        Click Element    ${sn_sc4}
        Sleep    1s
    ELSE IF  '${species}' == 'Wagyu' 
        Wait Until Page Contains Element    ${sn_sc5}   10s
        Click Element    ${sn_sc5}
        Sleep    1s
    END

Country
    [Arguments]  ${Country}

    Wait Until Page Contains Element  ${sn_Country}   10s
     Click Element    ${sn_Country}
    IF    '${country}' == 'Australia' 
        Wait Until Page Contains Element    ${sn_ct1}    10s
        Click Element    ${sn_ct1}
        Sleep    1s
    ELSE IF  '${country}' == 'New Zealand' 
        Wait Until Page Contains Element    ${sn_ct2}   10s
        Click Element    ${sn_ct2}
        Sleep    1s
    ELSE IF  '${country}' == 'South Africa' 
        Wait Until Page Contains Element    ${sn_ct3}   10s
        Click Element    ${sn_ct3}
        Sleep    1s
    ELSE IF  '${country}' == 'Namibia' 
        Wait Until Page Contains Element    ${sn_ct4}   10s
        Click Element    ${sn_ct4}
        Sleep    1s
    ELSE IF  '${country}' == 'United Kingdom' 
        Wait Until Page Contains Element    ${sn_ct5}   10s
        Click Element    ${sn_ct5}
        Sleep    1s
    ELSE IF  '${country}' == 'Canada' 
        Wait Until Page Contains Element    ${sn_ct6}   10s
        Click Element    ${sn_ct6}
        Sleep    1s
    ELSE IF  '${country}' == 'USA' 
        Wait Until Page Contains Element    ${sn_ct7}   10s
        Click Element    ${sn_ct7}
        Sleep    1s
    ELSE IF  '${country}' == 'Argentina' 
        Wait Until Page Contains Element    ${sn_ct8}   10s
        Click Element    ${sn_ct8}
        Sleep    1s
    END

# เลือกแม่พันธ์
# เลือกพ่อพันธ์
# เช็ค error



# --------------------------------------------------------------------------------------
# Check Home Page
#     [Arguments]  ${locator}
#     ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
#     ${Result}  Set Variable if    '${Status}'=='True'      เข้าสู่ระบบสำเร็จ            เข้าสู่ระบบไม่สำเร็จ 
#     [Return]     ${Result}