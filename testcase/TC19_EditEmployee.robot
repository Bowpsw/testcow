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
${vb_us}    xpath=//android.widget.EditText[@index='6']
${vb_pw}    xpath=//android.widget.EditText[@index='7']
${vb_login}    xpath=//android.view.View[@content-desc="เข้าสู่ระบบ"]
${vb_Emp}    //android.view.View[@index='8']

${vb_manu}    xpath=//android.widget.Button[@index='0'[1]]
${vb_Edit}    xpath=//android.widget.Button[@content-desc="แก้ไขข้อมูล"]
${sn_Gander}    xpath=//android.widget.Button[@index='3']
${sn_g1}    xpath=//android.view.View[@content-desc="นาย"]
${sn_g2}    xpath=//android.view.View[@content-desc="นาง"]
${sn_g3}    xpath=//android.view.View[@content-desc="นางสาว"]
${vt_Name}	xpath=//android.widget.EditText[@index='4']
${vt_LName}	xpath=//android.widget.EditText[@index='5']
${vt_us}		xpath=//android.widget.EditText[@index='6']
${vt_pass}	xpath=//android.widget.EditText[@index='7']
${vt_email}	xpath=//android.widget.EditText[@index='8']
${vt_phone}	xpath=//android.widget.EditText[@index='9']
${sn_posit}	xpath=//android.widget.Button[@index='10']
${sn_emp}	xpath=//android.view.View[@content-desc="พนักงาน"]
${sn_head}	xpath=//android.view.View[@content-desc="หัวหน้าพนักงาน"]

${vb_Button}	xpath=(//android.view.View[@content-desc="แก้ไขข้อมูลพนักงาน"])[2]
${vb_ms}	xpath=//android.view.View[@content-desc="กรุณากรอกข้อมูลให้ครบถ้วน"]

# ...    //android.widget.ImageView[@index='0']
${testcaseData} 
${Status} 

*** Test Cases ***
TC19_EditEmployee
    # Start Video Recording    name=D:/robot_pjtest/results/TC19_EditEmployee/video/TC19_EditEmployee  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC19_EditEmployee.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
        Open Test Application
        LoginPage 
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}

            ${Prefix}    Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
            ${Name}    Set Variable if    '${excel.cell(${i},4).value}'=='None'    ${Empty}     ${excel.cell(${i},4).value}
            ${Lname}    Set Variable if    '${excel.cell(${i},5).value}'=='None'    ${Empty}     ${excel.cell(${i},5).value}
            ${us}    Set Variable if    '${excel.cell(${i},6).value}'=='None'    ${Empty}     ${excel.cell(${i},6).value}
            ${pw}    Set Variable if    '${excel.cell(${i},7).value}'=='None'    ${Empty}     ${excel.cell(${i},7).value}
            ${email}    Set Variable if    '${excel.cell(${i},8).value}'=='None'    ${Empty}     ${excel.cell(${i},8).value}
            ${phone}    Set Variable if    '${excel.cell(${i},9).value}'=='None'    ${Empty}     ${excel.cell(${i},9).value}
            ${posit}    Set Variable if    '${excel.cell(${i},10).value}'=='None'    ${Empty}     ${excel.cell(${i},10).value}
            
            Edit Input Text    ${Prefix}    ${Name}    ${Lname}    ${us}    ${pw}    ${email}    ${phone}    ${posit}
            
            ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}     Check Error page        ${excel.cell(${i},11).value}
            ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
            Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC19_EditEmployee/Screenshot/${tcid}.png
            ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}

        
            ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
            ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},11).value}"    -


            Write Excel Cell        ${i}    12       value=${get_message}       sheet_name=TestData
            Write Excel Cell        ${i}    13       value=${Status}           sheet_name=TestData
            Write Excel Cell        ${i}    14       value=${Error}             sheet_name=TestData
            Write Excel Cell        ${i}    15       value=${Suggestion}        sheet_name=TestData
            Close Application
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC19_EditEmployee//WriteExcel//TC19_EditEmployee_Result.xlsx
    Close All Excel Documents
    
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
    # Sleep  3s
    Wait Until Page Contains Element    ${vb_Emp}   5s
    Click Element    ${vb_Emp}
    Sleep  3s

Edit Input Text    
    [Arguments]     ${Prefix}    ${Name}    ${Lname}    ${us}    ${pw}    ${email}    ${phone}    ${posit}
    Wait Until Page Contains Element    ${vb_manu}   5s
    Click Element    ${vb_manu}
    Wait Until Page Contains Element    ${vb_Edit}   5s
    Click Element    ${vb_Edit}
    # เพศ
    Wait Until Page Contains Element  ${sn_Gander}   10s
    Click Element    ${sn_Gander}
    IF    '${Prefix}' == 'นาย' 
        Wait Until Page Contains Element    ${sn_g1}    10s
        Click Element    ${sn_g1}
        Sleep    1s
    ELSE IF  '${Prefix}' == 'นาง' 
        Wait Until Page Contains Element    ${sn_g2}   10s
        Click Element    ${sn_g2}
        Sleep    1s
    ELSE
        Wait Until Page Contains Element    ${sn_g3}   10s
        Click Element    ${sn_g3}
        Sleep    1s
    END
    Wait Until Page Contains Element  ${vt_Name}   5s
    Click Element    ${vt_Name}    
    Input Text    ${vt_Name}    ${Name}
    Sleep  2s
    Click Element    ${vt_LName}    
    Input Text    ${vt_LName}    ${Lname}
    Sleep  2s 
    Click Element    ${vt_us}   
    Input Text    ${vt_us}    ${us}
    Sleep  2s  
    Click Element    ${vt_pass}    
    Input Text    ${vt_pass}    ${pw} 
    Sleep  2s 
    Click Element    ${vt_email}    
    Input Text    ${vt_email}    ${email} 
    Sleep  2s
    Click Element    ${vt_phone}   
    Input Text    ${vt_phone}    ${phone}

    Wait Until Page Contains Element    ${sn_posit}  10s
    Click Element    ${sn_posit}
    IF    '${posit}' == 'พนักงาน' 
        Wait Until Page Contains Element    ${sn_emp}    10s
        Click Element    ${sn_emp}
        Sleep    1s
    ELSE IF  '${posit}' == 'หัวหน้าพนักงาน' 
        Wait Until Page Contains Element    ${sn_head}   10s
        Click Element    ${sn_head}
        Sleep    1s
    END
    Wait Until Page Contains Element  ${vb_Button}    5s  
    Click Element  ${vb_Button}

# ติด
Check Error page 
   [Arguments]    ${Actual_Result}
   Log To Console  ${testcaseData} 
   
    IF   '${testcaseData}' == 'TC001' or '${testcaseData}' == 'TC002' or '${testcaseData}' == 'TC003' or '${testcaseData}' == 'TC005' or '${testcaseData}' == 'TC007' or '${testcaseData}' == 'TC008' or '${testcaseData}' == 'TC009' or '${testcaseData}' == 'TC010' or '${testcaseData}' == 'TC015' or '${testcaseData}' == 'TC017' or '${testcaseData}' == 'TC018' or '${testcaseData}' == 'TC019' or '${testcaseData}' == 'TC020' or '${testcaseData}' == 'TC024' or '${testcaseData}' == 'TC026' or '${testcaseData}' == 'TC027' or '${testcaseData}' == 'TC028'
            ${message}   Check Edit Page   ${vb_ms} 
            
        ELSE IF  '${testcaseData}' == 'TC029' or '${testcaseData}' == 'TC034' or '${testcaseData}' == 'TC036' or '${testcaseData}' == 'TC037' or '${testcaseData}' == 'TC038' or '${testcaseData}' == 'TC039' or '${testcaseData}' == 'TC040' or '${testcaseData}' == 'TC045' or '${testcaseData}' == 'TC048' or '${testcaseData}' == 'TC049' or '${testcaseData}' == 'TC050' or '${testcaseData}' == 'TC051' or '${testcaseData}' == 'TC056' or '${testcaseData}' == 'TC058' or '${testcaseData}' == 'TC059' or '${testcaseData}' == 'TC060' or '${testcaseData}' == 'TC066' or '${testcaseData}' == 'TC067'
            ${message}   Check Edit Page  ${vb_ms} 
        ELSE  
        Wait Until Element Is Visible  xpath=//android.view.View[@index='0']
        ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element  xpath=//android.view.View[@index='0']
        Log To Console  ${checkVisible}
        IF  '${checkVisible}' == 'True'
            Wait Until Element Is Visible  xpath=//android.view.View[@index='0']
            ${get_message}  Get Text  xpath=//android.view.View[@index='0']
            ${message}  Convert To String  ${get_message}
           # Click Element  ${submit_alert}
        END
    END


  IF  '${Actual_Result.strip()}' == '${message.strip()}'
            Set Suite Variable  ${Status}  True
        ELSE
            Set Suite Variable  ${Status}  False
        END

        Log To Console      ${Status}
        Log To Console      ${message}

      [Return]   ${Status}  ${message}


Check Edit Page
    [Arguments]  ${locator}
    ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
    ${Result}  Set Variable if    '${Status}'=='True'      แก้ไขข้อมูลพนักงานเสร็จเรียบร้อยแล้ว
    [Return]     ${Result}
