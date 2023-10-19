*** Settings *** 
Library    AppiumLibrary
Library   ExcelLibrary
Library	  Collections
Library    ScreenCapLibrary
Library    openpyxl
Library    ../Scripts/SelectDay.py
Resource    ../resource/RS_AndroidConfig.robot

*** Variables ***
${vbc_manu}    xpath=//android.widget.Button[@index='0']
${vbc_manu2}    xpath=//android.view.View[@index='1']
${vbc_emp}    xpath=//android.widget.RadioButton[@index='4']
${vb_us}    xpath=//android.widget.EditText[@index='6']
${vb_pw}    xpath=//android.widget.EditText[@index='7']
${vb_login}    xpath=//android.view.View[@content-desc="เข้าสู่ระบบ"]
${vb_manu}    xpath=//android.widget.Button[@index='0'[2]]

${bt_add}    xpath=//android.widget.Button[@content-desc="เพิ่มข้อมูลพัฒนาการโค"]
${vd_dete}		xpath=//android.view.View[@index='3']
${vt_weight}		xpath=//android.widget.EditText[@index='4']
${vt_height}		xpath=//android.widget.EditText[@index='5']
${add_data}    xpath=//android.view.View[@index='6']

${bt_bb}    xpath=//android.widget.Button[@index='0']

${HEADER_YEAR}        xpath=//android.widget.Button[@content-desc="2023"]
${HEADER_DATE}        id=android:id/date_picker_header_date
${OK_YEAR_BTN}        id=android:id/button1
${YEAR_LIST}          xpath=//android.widget.ListView/android.widget.TextView
${MONTH_AND_YEAR}     xpath=(//android.view.View/android.view.View)[1]
${PREV_BTN}           id=android:id/prev
${NEXT_BTN}           id=android:id/next
${DAY_LIST}           xpath=//android.view.View/android.view.View

${Matching_VB}    xpath=//android.view.View[@index='1']
${alert_add}    xpath=//android.view.View[@content-desc="กรุณากรอกข้อมูลให้ครบถ้วน"]
${testcaseData} 
${Status} 

*** Test Cases ***
TC05_AddCowprogress
    # Start Video Recording    name=D:/robot_pjtest/results/TC05_AddCowprogress/video/TC05_AddCowprogress  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC05_AddCowprogress.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    Open Test Application
    LoginPage
    Goto add
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
            
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}
            ${RD}     Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
            ${W}     Set Variable if    '${excel.cell(${i},4).value}'=='None'    ${Empty}     ${excel.cell(${i},4).value}
            ${H}     Set Variable if    '${excel.cell(${i},5).value}'=='None'    ${Empty}     ${excel.cell(${i},5).value}
            
            # Date development cow    ${RD}
            Input weight height    ${W}    ${H}
            
            
            ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}    Check Error page    ${excel.cell(${i},6).value}
            ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
            Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC05_AddCowprogress/Screenshot/${tcid}.png
            ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}


            ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
            ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},6).value}"


            Write Excel Cell        ${i}    7       value=${get_message}       sheet_name=TestData
            Write Excel Cell        ${i}    8       value=${Status}           sheet_name=TestData
            Write Excel Cell        ${i}    9       value=${Error}        sheet_name=TestData
            Write Excel Cell        ${i}    10       value=${Suggestion}        sheet_name=TestData
            
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC05_AddCowprogress//WriteExcel//TC05_AddCowprogress_Result.xlsx
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
    Sleep  3s

Goto add
    Wait Until Page Contains Element   ${vb_manu}   1s
    Click Element    ${vb_manu}
    Wait Until Page Contains Element   ${bt_add}   1s
    Click Element     ${bt_add}
    Sleep  3s

Date development cow 
    [Arguments]   ${RD}
    Click Element    ${vd_dete}

    #เช็คปีเดือนปัจจุบัน
    ${CURR_YEAR}    Get Text    ${HEADER_YEAR}
    ${CURR_DATE}    Get Text    ${HEADER_DATE}

    Click Element    ${HEADER_YEAR}
    Sleep    5s
    #ดึงค่าจาก ไพทอน และ จาก excel
    ${DATE_TARGET_ARRAY}=    Split Str By Slash    ${day}
    # วันที่เราต้องการ
    ${TARGET_DAY}=    Set Variable    ${DATE_TARGET_ARRAY}[0]
    # เดือนที่เราต้องการ
    ${TARGET_MONTH}=    Set Variable    ${DATE_TARGET_ARRAY}[1]
    # ปีที่เราต้องการ
    ${TARGET_YEAR}=    Set Variable    ${DATE_TARGET_ARRAY}[2]
    #loop ปี
    FOR    ${j}  IN RANGE    999999
        ${elements}    Get Webelements    ${YEAR_LIST}

        ${flag}    Set Variable    20
        ${str}    Set Variable    20

        FOR    ${elem}    IN    @{elements}
            ${str}=    Get Text    ${elem}
            IF    ${str} == ${TARGET_YEAR}
                Click Element    ${elem}
                ${flag}    Set Variable    ${str}
                Exit For Loop
            END
            Log To Console    ${str}
        END
        
        Exit For Loop If    ${str} == ${flag}
        #เลื่อนหาปีที่ต้องการ
        ${FIRST_ELEM}=    Set Variable    ${elements}[0]
        ${TEXT_OF_FIRST}=    Get Text    ${FIRST_ELEM} 
        IF    ${TEXT_OF_FIRST} < ${TARGET_YEAR}
            Swipe By Percent    50    60    50    33    1000
        ELSE IF    ${TEXT_OF_FIRST} > ${TARGET_YEAR}
            Swipe By Percent    50    33    50    60    1000
        END
    END
    # Print ค่า ออกมา
    Log To Console    "CUR YEAR IS ${CURR_YEAR}"
    Log To Console    "CUR DATE IS ${CURR_DATE}"

    Sleep    1s
    # loop เอาค่า หรือ Xpath ของ MONTH_AND_YEAR ไปใส่ res_content_desc
    FOR  ${j}  IN RANGE    100
        ${content_desc}=    Get Element Attribute    ${MONTH_AND_YEAR}    content-desc
        ${res_content_desc}=    Split Month And Date    ${content_desc}
        ${date}=    Set Variable    ${res_content_desc}[0]
        ${month}=    Set Variable    ${res_content_desc}[1]
        ${num_month}=    Convert Month To Number    ${month}
        IF    ${num_month} > ${TARGET_MONTH}
            Click Element    ${PREV_BTN}
        ELSE IF    ${num_month} < ${TARGET_MONTH}
            Click Element    ${NEXT_BTN}
        ELSE
            ${days}    Get Webelements    ${DAY_LIST}
            FOR    ${day}    IN    @{days}
                ${day_content_desc}=    Get Element Attribute    ${day}    content-desc
                ${day_content_desc_arr}=    Split Str By Space    ${day_content_desc}
                ${real_day}=    Set Variable    ${day_content_desc_arr}[0]
                ${num_day}=     Str To Int    ${real_day}
                IF    ${num_day} == ${TARGET_DAY}
                    Sleep    3s
                    Click Element    ${day}
                    Exit For Loop
                END
            END
            Exit For Loop
        END
    END

Input weight height
    [Arguments]   ${weight}    ${height}
    Click Element    ${vt_weight}
    Input Text  ${vt_weight}    ${weight}
    Click Element    ${vt_height}
    Input Text  ${vt_height}  ${height}
    Sleep  3s
    Click Element    ${add_data}
    Sleep  3s
    
Check Error page 
   [Arguments]    ${Actual_Result}
   Log To Console  ${testcaseData} 

    IF   '${testcaseData}' == 'TC001' or '${testcaseData}' == 'TC002' or '${testcaseData}' == 'TC005'
           ${message}  Check Home Page  ${Matching_VB} 

    ELSE  
        Wait Until Element Is Visible  ${alert_add} 
        ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element  ${alert_add}   
        Log To Console  ${checkVisible}
        IF  '${checkVisible}' == 'True'
            Wait Until Element Is Visible  ${alert_add} 
            ${get_message}  Get Text  ${alert_add}
            ${message}  Check Home Page  ${get_message}
            # ${message}    Convert To String    ${get_message}
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


Check Home Page
    [Arguments]  ${locator}
    ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
    ${Result}  Set Variable if    '${Status}'=='True'      Not Found Alert Element            กรุณากรอกข้อมูลให้ครบถ้วน 
    [Return]     ${Result}

