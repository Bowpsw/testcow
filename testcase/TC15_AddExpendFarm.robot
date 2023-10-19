*** Settings *** 
Library    AppiumLibrary
Library   ExcelLibrary
Library	  Collections
Library    ScreenCapLibrary
Library    openpyxl
Library        ../Scripts/SplitMonthAndDate.py
Resource    ../resource/RS_AndroidConfig.robot


*** Variables ***
${vbc_manu}    xpath=//android.widget.Button[@index='0']
${vbc_manu2}    xpath=//android.view.View[@index='1']
${vbc_emp}    xpath=//android.widget.RadioButton[@index='4']
${vb_us}    xpath=//android.widget.EditText[@index='6']
${vb_pw}    xpath=//android.widget.EditText[@index='7']
${vb_login}    xpath=//android.view.View[@content-desc="เข้าสู่ระบบ"]
${vb_exp}    xpath=//android.view.View[@index='9']

${vb_add}    xpath=//android.widget.Button[@content-desc="เพิ่มข้อมูล"]
${vb_Pname}    xpath=//android.widget.EditText[@index='4']
${vt_Amount}	xpath=//android.widget.EditText[@index='5']
${vt_price}    xpath=//android.widget.EditText[@index='6']
${sn_Etype}    xpath=//android.widget.Button[@index='7']
${sn_Etype1}    xpath=//android.view.View[@content-desc="อาหาร"]
${sn_Etype2}    xpath=//android.view.View[@content-desc="วัคซีน"]
${sn_Etype3}    xpath=//android.view.View[@content-desc="อื่นๆ"]
${vt_Ntype}    xpath=//android.widget.EditText[@text='ชื่อประเภทอื่นๆ']

${bt_Addexp}    xpath=//android.view.View[@content-desc="เพิ่มข้อมูลค่าใช้จ่ายฟาร์ม"]

${testcaseData} 
${Status} 

*** Test Cases ***
TC15_AddExpendFarm
    # Start Video Recording    name=D:/robot_pjtest/results/TC15_AddExpendFarm/video/TC15_AddExpendFarm  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC15_AddExpendFarm.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
        Open Test Application
        LoginPage 
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}

            ${EFD}     Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
            ${Pname}     Set Variable if    '${excel.cell(${i},4).value}'=='None'    ${Empty}     ${excel.cell(${i},4).value}
            ${Amount}     Set Variable if    '${excel.cell(${i},5).value}'=='None'    ${Empty}     ${excel.cell(${i},5).value}
            ${price}     Set Variable if    '${excel.cell(${i},6).value}'=='None'    ${Empty}     ${excel.cell(${i},6).value}
            ${Etype}     Set Variable if    '${excel.cell(${i},7).value}'=='None'    ${Empty}     ${excel.cell(${i},7).value}
            ${OET}     Set Variable if    '${excel.cell(${i},8).value}'=='None'    ${Empty}     ${excel.cell(${i},8).value}
            
            Input    ${Pname}    ${Amount}    ${price}    ${Etype}    ${OET}

            ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}    Check Error page    ${excel.cell(${i},9).value}
            ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS    FAIL
            Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC15_AddExpendFarm/Screenshot/${tcid}.png
            
            ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}
            ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
            ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},9).value}"    -

            Write Excel Cell        ${i}    10       value=${get_message}       sheet_name=TestData
            Write Excel Cell        ${i}    11       value=${Status}           sheet_name=TestData
            Write Excel Cell        ${i}    12       value=${Error}        sheet_name=TestData
            Write Excel Cell        ${i}    13       value=${Suggestion}        sheet_name=TestData
            Close Application 

        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC15_AddExpendFarm//WriteExcel//TC15_AddExpendFarm_Result.xlsx
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
    Wait Until Page Contains Element    ${vb_Exp}   5s
    Click Element    ${vb_Exp}
    Wait Until Page Contains Element    ${vb_add}   5s
    Click Element    ${vb_add}

# วันที่ซื้อสินค้า
# Date    [Arguments]  ${EFD}
#     Click Element    //android.view.View[@index='3']

#     #เช็คปีเดือนปัจจุบัน
#     ${CURR_YEAR}    Get Text	//android.widget.Button[@content-desc="Select year"]
#     ${CURR_DATE}    Get Text    //android.view.View[@index='2']

#     Click Element    //android.widget.Button[@content-desc="Select year"]
#     Sleep    5s
#     #ดึงค่าจาก ไพทอน และ จาก excel
#     ${DATE_TARGET_ARRAY}=    Split Str By Slash    ${day}
#     # วันที่เราต้องการ
#     ${TARGET_DAY}=    Set Variable    ${DATE_TARGET_ARRAY}[0]
#     # เดือนที่เราต้องการ
#     ${TARGET_MONTH}=    Set Variable    ${DATE_TARGET_ARRAY}[1]
#     # ปีที่เราต้องการ
#     ${TARGET_YEAR}=    Set Variable    ${DATE_TARGET_ARRAY}[2]
#     #loop ปี
#     FOR    ${j}  IN RANGE    999999
#         ${elements}    Get Webelements    ${YEAR_LIST}

#         ${flag}    Set Variable    20
#         ${str}    Set Variable    20

#         FOR    ${elem}    IN    @{elements}
#             ${str}=    Get Text    ${elem}
#             IF    ${str} == ${TARGET_YEAR}
#                 Click Element    ${elem}
#                 ${flag}    Set Variable    ${str}
#                 Exit For Loop
#             END
#             Log To Console    ${str}
#         END
        
#         Exit For Loop If    ${str} == ${flag}
#         #เลื่อนหาปีที่ต้องการ
#         ${FIRST_ELEM}=    Set Variable    ${elements}[0]
#         ${TEXT_OF_FIRST}=    Get Text    ${FIRST_ELEM} 
#         IF    ${TEXT_OF_FIRST} < ${TARGET_YEAR}
#             Swipe By Percent    50    60    50    33    1000
#         ELSE IF    ${TEXT_OF_FIRST} > ${TARGET_YEAR}
#             Swipe By Percent    50    33    50    60    1000
#         END
#     END
#     # Print ค่า ออกมา
#     Log To Console    "CUR YEAR IS ${CURR_YEAR}"
#     Log To Console    "CUR DATE IS ${CURR_DATE}"

#     Sleep    1s
#     # loop เอาค่า หรือ Xpath ของ MONTH_AND_YEAR ไปใส่ res_content_desc
#     FOR  ${j}  IN RANGE    100
#         ${content_desc}=    Get Element Attribute    ${MONTH_AND_YEAR}    content-desc
#         ${res_content_desc}=    Split Month And Date    ${content_desc}
#         ${date}=    Set Variable    ${res_content_desc}[0]
#         ${month}=    Set Variable    ${res_content_desc}[1]
#         ${num_month}=    Convert Month To Number    ${month}
#         IF    ${num_month} > ${TARGET_MONTH}
#             Click Element    ${PREV_BTN}
#         ELSE IF    ${num_month} < ${TARGET_MONTH}
#             Click Element    ${NEXT_BTN}
#         ELSE
#             ${days}    Get Webelements    ${DAY_LIST}
#             FOR    ${day}    IN    @{days}
#                 ${day_content_desc}=    Get Element Attribute    ${day}    content-desc
#                 ${day_content_desc_arr}=    Split Str By Space    ${day_content_desc}
#                 ${real_day}=    Set Variable    ${day_content_desc_arr}[0]
#                 ${num_day}=     Str To Int    ${real_day}
#                 IF    ${num_day} == ${TARGET_DAY}
#                     Sleep    3s
#                     Click Element    ${day}
#                     Exit For Loop
#                 END
#             END
#             Exit For Loop
#         END
#     END  


Input 
    [Arguments]     ${Pname}    ${Amount}    ${price}    ${Etype}    ${OET}
    Wait Until Page Contains Element    ${vb_Pname}   5s
    Click Element    ${vb_Pname}
    Input Text    ${vb_Pname}    ${Pname}
    Sleep    2s
    Click Element    ${vt_Amount}
    Input Text    ${vt_Amount}    ${Amount}
    Sleep    2s
    Click Element    ${vt_price}
    Input Text    ${vt_price}    ${price}
    Sleep    2s
    Click Element    ${sn_Etype}
    Sleep    5s
    
    IF    '${Etype}' == 'อาหาร' 
        Wait Until Page Contains Element    ${sn_Etype1}    10s
        Click Element    ${sn_Etype1}
        Sleep    1s
    ELSE IF  '${Etype}' == 'วัคซีน' 
        Wait Until Page Contains Element    ${sn_Etype2}  10s
        Click Element    ${sn_Etype2}
        Sleep    1s
    ELSE IF  '${Etype}' == 'อื่นๆ' 
        Wait Until Page Contains Element    ${sn_Etype3}  10s
        Click Element    ${sn_Etype3}
        Sleep    2s
        Click Element    ${vt_Ntype}
        Input Text    ${vt_Ntype}    ${OET}
        Sleep    2s
    END
    Sleep    1s
    Click Element    ${bt_Addexp}

# Check Error page 
#    [Arguments]    ${Actual_Result}
#    Log To Console  ${testcaseData} 

#     IF   '${testcaseData}' == 'TC001' or '${testcaseData}' == 'TC002' or '${testcaseData}' == 'TC005'
#            ${message}  Check Home Page  ${Matching_VB} 

#     ELSE  
#         Wait Until Element Is Visible  ${alert_add} 
#         ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element  ${alert_add}   
#         Log To Console  ${checkVisible}
#         IF  '${checkVisible}' == 'True'
#             Wait Until Element Is Visible  ${alert_add} 
#             ${get_message}  Get Text  ${alert_add}
#             ${message}  Check Home Page  ${get_message}
#             # ${message}    Convert To String    ${get_message}
#            # Click Element  ${submit_alert}
#         END
#     END

#     IF  '${Actual_Result.strip()}' == '${message.strip()}'
#             Set Suite Variable  ${Status}  True
#         ELSE
#             Set Suite Variable  ${Status}  False
#         END

#         Log To Console      ${Status}
#         Log To Console      ${message}

#       [Return]   ${Status}  ${message}

# Check Home Page
#     [Arguments]  ${locator}
#     ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
#     ${Result}  Set Variable if    '${Status}'=='True'      Not Found Alert Element            กรุณากรอกข้อมูลให้ครบถ้วน 
#     [Return]     ${Result}


