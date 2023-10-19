*** Settings *** 
Library    AppiumLibrary
Library   ExcelLibrary
Library	  Collections
Library    ScreenCapLibrary
Library    openpyxl
Resource    ../resource/RS_AndroidConfig.robot

*** Variables ***
${vb_search}    xpath=//android.widget.EditText[@index='1']
${text_search}    xpath=//android.view.View[@index='0']       

${text_message}    xpath=//android.view.View[@index='2']

${testcaseData} 
${Status} 

*** Test Cases ***
TC01_Search
    Start Video Recording    name=D:/robot_pjtest/results/TC01_Search/video/TC01_Search  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC01_Search.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
            Open Test Application
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}
            ${search}     Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}


            KeyInformation    ${search}
            ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}    Check Error page    ${excel.cell(${i},4).value}
            ${Status}            Set Variable if    '${Status_1}' == 'True'    PASS    FAIL
            Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC01_Search/Screenshot/${tcid}.png    

            ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}
            ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error        No Error  
            ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},4).value}"    -
            

            Write Excel Cell        ${i}    5       value=${get_message}       sheet_name=TestData
            Write Excel Cell        ${i}    6       value=${Status}           sheet_name=TestData
            Write Excel Cell        ${i}    7       value=${Error}        sheet_name=TestData
            Write Excel Cell        ${i}    8       value=${Suggestion}        sheet_name=TestData
            Close Application 
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC01_Search//WriteExcel//TC01_Search_Result.xlsx
    Close All Excel Documents
    
    Stop Video Recording      alias=None

*** Keywords ***
Open Test Application
  Open Application  http://localhost:4723/wd/hub  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
  ...  app=${ANDROID_APP}  appPackage=com.example.cow_mange    appActivity=.MainActivity

KeyInformation 
    [Arguments]   ${Ksearch}  
    Click Element    ${vb_search}
    Wait Until Page Contains Element  ${vb_search}   5s
    Input Text  ${vb_search}  ${Ksearch}
    Sleep  1s

Check Error page 
   [Arguments]    ${Actual_Result}
   Log To Console  ${testcaseData} 
        IF   '${testcaseData}' == 'TC001' or '${testcaseData}' == 'TC002'
           ${message}  Check Page   ${text_search}
        ELSE IF    '${testcaseData}' == 'TC003'or '${testcaseData}' == 'TC004'
           ${message}  Check Page   ${text_search}
        
        ELSE  
            Wait Until Element Is Visible  ${text_message} 
            ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element  ${text_message}   
            Log To Console  ${checkVisible}
            IF  '${checkVisible}' == 'True'
                Wait Until Element Is Visible  ${text_message} 
                ${get_message}  Get Text  ${text_message}
                ${message}  Check Page   ${get_message}
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

Check Page
    [Arguments]  ${locator}
    ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
    ${Result}  Set Variable if    '${Status}'=='True'         ระบบคืนค่าค้นหาตามที่ผู้ใช้กรอก    Not Found Alert Element
    [Return]     ${Result}
