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
${vbc_own}    xpath=//android.widget.RadioButton[@index='4']
${vb_us}    xpath=//android.widget.EditText[@index='6']
${vb_pw}    xpath=//android.widget.EditText[@index='7']
${vb_login}    xpath=//android.view.View[@content-desc="เข้าสู่ระบบ"]

${alert_login}   //android.view.View[@index='1']
${Matching_VB}    xpath=//android.view.View[@index='0']
${testcaseData} 
${Status} 

*** Test Cases ***
TC13_LoginOwner
    Start Video Recording    name=D:/robot_pjtest/results/TC13_LoginOwner/video/TC13_LoginOwner  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC13_LoginOwner.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
            Open Test Application
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}
            ${user}     Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
            ${pass}     Set Variable if    '${excel.cell(${i},4).value}'=='None'    ${Empty}     ${excel.cell(${i},4).value}
        
            KeyInformation    ${user}    ${pass}
            ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}    Check Error page    ${excel.cell(${i},5).value}
            ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
            Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC13_LoginOwner/Screenshot/${tcid}.png
            ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}


            ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
            ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},5).value}"    -


            Write Excel Cell        ${i}    6       value=${get_message}       sheet_name=TestData
            Write Excel Cell        ${i}    7       value=${Status}           sheet_name=TestData
            Write Excel Cell        ${i}    8       value=${Error}        sheet_name=TestData
            Write Excel Cell        ${i}    9       value=${Suggestion}        sheet_name=TestData
            Close Application 
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC13_LoginOwner//WriteExcel//TC13_LoginOwner_Result.xlsx
    Close All Excel Documents
    
    Stop Video Recording      alias=None

*** Keywords ***
Open Test Application
  Open Application  http://localhost:4723/wd/hub  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
  ...  app=${ANDROID_APP}  appPackage=com.example.cow_mange    appActivity=.MainActivity

KeyInformation 
    [Arguments]   ${username}  ${password}
    Click Element    ${vbc_manu}
    Click Element    ${vbc_manu2}
    Click Element    ${vbc_own}
    Click Element    ${vb_us}  

    Input Text  ${vb_us}  ${username}
    Click Element    ${vb_pw}
    Input Text  ${vb_pw}  ${password}
    Click Element  ${vb_login}
    Sleep  3s

Check Error page 
   [Arguments]    ${Actual_Result}
   Log To Console  ${testcaseData} 

    IF   '${testcaseData}' == 'TC001' or '${testcaseData}' == 'TC003' or '${testcaseData}' == 'TC004' or '${testcaseData}' == 'TC005' or '${testcaseData}' == 'TC006'
           ${message}  Check Home Page  ${Matching_VB} 
           

    ELSE IF  '${testcaseData}' == 'TC012' or '${testcaseData}' == 'TC013' or '${testcaseData}' == 'TC014' or '${testcaseData}' == 'TC015'
         ${message}  Check Home Page  ${Matching_VB} 
        
    ELSE  
        Wait Until Element Is Visible  ${alert_login} 
        ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element  ${alert_login}   
        Log To Console  ${checkVisible}
        IF  '${checkVisible}' == 'True'
            Wait Until Element Is Visible  ${alert_login} 
            ${get_message}  Get Text  ${alert_login}
            ${message}  Check Home Page  ${get_message}
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


Check Home Page
    [Arguments]  ${locator}
    ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
    ${Result}  Set Variable if    '${Status}'=='True'      เข้าสู่ระบบสำเร็จ           กรุณากรอกข้อมูลให้ครบถ้วน 
    [Return]     ${Result}