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
${vb_manu}    xpath=//android.widget.ImageView[@index='0'[3]]

${vb_data}    xpath=//android.view.View[@content-desc="ข้อมูลอื่นๆ"]
${vb_sn}    xpath=//android.widget.Button[@content-desc="ข้อมูลโค"]
${vb_cprogress}    xpath=//android.view.View[@content-desc="ให้อาหารโค"]

${vb_Swipe}    xpath=//android.widget.ImageView[@index='0'][1]
${vb_Remove}    xpath=//android.widget.Button[@content-desc="ลบข้อมูลการให้อาหารโค"]
${vb_Cancel}    xpath=//android.widget.Button[@content-desc="No"]
${vb_delete}    xpath=//android.widget.Button[@content-desc="Yes"]
${vt_ms}    xpath=//android.view.View[@content-desc="เช็คข้อมูลการลบข้อมูลทุกครั้ง"]
${testcaseData} 
${Status} 

*** Test Cases ***
TC08_RemoveFeeding
    Start Video Recording    name=D:/robot_pjtest/results/TC08_RemoveFeeding/video/TC08_RemoveFeeding  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC08_RemoveFeeding.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
        Open Test Application
        LoginPage 
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}

            ${rp}     Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
        
            dr
            
            ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}     Check Error page        ${excel.cell(${i},4).value}
            ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
            Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC08_RemoveFeeding/Screenshot/${tcid}.png

            ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}

        
            ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
            ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},4).value}"


            Write Excel Cell        ${i}    5       value=${get_message}       sheet_name=TestData
            Write Excel Cell        ${i}    6       value=${Status}           sheet_name=TestData
            Write Excel Cell        ${i}    7       value=${Error}             sheet_name=TestData
            Write Excel Cell        ${i}    8       value=${Suggestion}        sheet_name=TestData
            Close Application
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC08_RemoveFeeding//WriteExcel//TC08_RemoveFeeding_Result.xlsx
    Close All Excel Documents
    
    Stop Video Recording      alias=None

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
    Wait Until Page Contains Element    ${vb_manu}    5s
    Click Element    ${vb_manu}
    Sleep  3s

dr
    Swipe By Percent	50	90	50	20	4000
    Wait Until Page Contains Element    ${vb_data}    5s
    Click Element    ${vb_data}
    Wait Until Page Contains Element    ${vb_sn}    10s
    Click Element    ${vb_sn}
    Sleep    2s
    Wait Until Page Contains Element    ${vb_cprogress}    5s
    Click Element    ${vb_cprogress}
    Swipe By Percent	50	90	50	20	4000
    Swipe By Percent	50    50    10    50    1000
    Sleep  3s
    Click Element    ${vb_Remove}

Check Error page 
    [Arguments]     ${Actual_Result}
         Log To Console  ${testcaseData}
        IF  "${testcaseData}" == "TC001"
                Wait Until Page Contains Element     ${vt_ms}   10s 
                ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element    ${vt_ms}
                Log To Console  ${checkVisible} 
                IF  '${checkVisible}' == 'True'
                Wait Until Element Is Visible     ${vt_ms}
                ${get_message}  Get Text      ${vt_ms} 
                ${message}  Check Home Page   ${get_message}
                Click Element    ${vb_delete}
                Sleep  7s
           END 
           
        ELSE IF  "${testcaseData}" == "TC002"
                Wait Until Page Contains Element     ${vt_ms}   10s 
                ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element   ${vt_ms}   
                Log To Console  ${checkVisible} 
                IF  '${checkVisible}' == 'True'
                Wait Until Element Is Visible     ${vt_ms} 
                ${get_message}  Get Text      ${vt_ms}
                ${message}  Check Home Page   ${get_message}
                Click Element    ${vb_Cancel}
                Sleep  7s
           END
         END

        IF  '${Actual_Result.strip()}' == '${message.strip()}'
            Set Suite Variable  ${Status}  True
        ELSE
            Set Suite Variable  ${Status}  False
        END

        Log To Console      ${message}
        Log To Console      ${Status}
        [Return]   ${Status}  ${message}

Check Home Page
    [Arguments]  ${locator}
    ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
    ${Result}  Set Variable if    '${Status}'=='True'      Not Found Alert Element    Not Found Alert Element 
    [Return]     ${Result}