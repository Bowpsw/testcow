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
${vb_Rg}    xpath=//android.view.View[@content-desc="ยังไม่ได้สมัครสมาชิก? สมัครคลิกตรงนี้"]

${sn_Gander}    xpath=//android.widget.Button[@index='4']
${sn_g1}    xpath=//android.view.View[@content-desc="นาง"]
${sn_g2}    xpath=//android.view.View[@content-desc="นาย"]
${sn_g3}    xpath=//android.view.View[@content-desc="นางสาว"]

${vt_Name}    xpath=//android.widget.EditText[@index='5']
${vt_LName}    xpath=//android.widget.EditText[@index='6']
${vt_us}    xpath=//android.widget.EditText[@index='7']
${vt_pass}    xpath=//android.widget.EditText[@index='8']
${vt_email}    xpath=//android.widget.EditText[@index='9']
${vt_phone}    xpath=//android.widget.EditText[@index='10']

${vt_Fname}    xpath=//android.widget.EditText[@index='4']
${sn_Ftype}    xpath=//android.widget.Button[@index='5']

${sn_Ftype1}		xpath=//android.view.View[@content-desc="บริษัท"]
${sn_Ftype2}		xpath=//android.view.View[@content-desc="ประกัน"]
${sn_Ftype3}		xpath=//android.view.View[@content-desc="ราชการ"]
${sn_Ftype4}		xpath=//android.view.View[@content-desc="อิสระ"]
${sn_Ftype5}		xpath=//android.view.View[@content-desc="ไม่ระบุ"]

${vb_Button}	xpath=//android.view.View[@content-desc="ลงทะเบียนฟาร์ม"]
# ${vb_ms}	xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View

${testcaseData} 
${Status} 

*** Test Cases ***
TC14_RegisterOwner
    # Start Video Recording    name=D:/robot_pjtest/results/TC14_RegisterOwner/video/TC14_RegisterOwner  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC14_RegisterOwner.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
        Open Test Application
        go to Page 
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}

            ${Prefix}    Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
            ${Name}    Set Variable if    '${excel.cell(${i},4).value}'=='None'    ${Empty}     ${excel.cell(${i},4).value}
            ${Lname}    Set Variable if    '${excel.cell(${i},5).value}'=='None'    ${Empty}     ${excel.cell(${i},5).value}
            ${us}    Set Variable if    '${excel.cell(${i},6).value}'=='None'    ${Empty}     ${excel.cell(${i},6).value}
            ${pw}    Set Variable if    '${excel.cell(${i},7).value}'=='None'    ${Empty}     ${excel.cell(${i},7).value}
            ${email}    Set Variable if    '${excel.cell(${i},8).value}'=='None'    ${Empty}     ${excel.cell(${i},8).value}
            ${phone}    Set Variable if    '${excel.cell(${i},9).value}'=='None'    ${Empty}     ${excel.cell(${i},9).value}
            ${AD}    Set Variable if    '${excel.cell(${i},10).value}'=='None'    ${Empty}     ${excel.cell(${i},10).value}
            ${MB}    Set Variable if    '${excel.cell(${i},11).value}'=='None'    ${Empty}     ${excel.cell(${i},11).value}
            ${S}    Set Variable if    '${excel.cell(${i},12).value}'=='None'    ${Empty}     ${excel.cell(${i},12).value}
            ${R}    Set Variable if    '${excel.cell(${i},13).value}'=='None'    ${Empty}     ${excel.cell(${i},13).value}
            ${SA}    Set Variable if    '${excel.cell(${i},14).value}'=='None'    ${Empty}     ${excel.cell(${i},14).value}
            ${D}    Set Variable if    '${excel.cell(${i},15).value}'=='None'    ${Empty}     ${excel.cell(${i},15).value}
            ${P}    Set Variable if    '${excel.cell(${i},16).value}'=='None'    ${Empty}     ${excel.cell(${i},16).value}
            ${PC}    Set Variable if    '${excel.cell(${i},17).value}'=='None'    ${Empty}     ${excel.cell(${i},17).value}
            ${Fname}    Set Variable if    '${excel.cell(${i},18).value}'=='None'    ${Empty}     ${excel.cell(${i},18).value}
            ${Ftype}    Set Variable if    '${excel.cell(${i},19).value}'=='None'    ${Empty}     ${excel.cell(${i},19).value}
            ${Picture}    Set Variable if    '${excel.cell(${i},20).value}'=='None'    ${Empty}     ${excel.cell(${i},20).value}

            Input Text page     ${Prefix}    ${Name}    ${Lname}    ${us}    ${pw}    ${email}    ${phone} 
            Input farm    ${Fname}    ${Ftype} 

            Wait Until Page Contains Element    ${vb_Button}   10s
            Click Element    ${vb_Button}   
            # ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${excel.max_row}     Check Error page        ${excel.cell(${i},11).value}
            # ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
            # Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    D:/robot_pjtest/results/TC14_RegisterOwner/Screenshot/${tcid}.png
            # ${get_message}       Set Variable if    ${i}<=${excel.max_row}   ${message_1}

            # ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
            # ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${excel.cell(${i},11).value}"

            # Write Excel Cell        ${i}    12       value=${get_message}       sheet_name=TestData
            # Write Excel Cell        ${i}    13       value=${Status}           sheet_name=TestData
            # Write Excel Cell        ${i}    14       value=${Error}             sheet_name=TestData
            # Write Excel Cell        ${i}    15       value=${Suggestion}        sheet_name=TestData
            Close Application
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC14_RegisterOwner//WriteExcel//TC14_RegisterOwner_Result.xlsx
    Close All Excel Documents
    
    # Stop Video Recording      alias=None

*** Keywords ***
Open Test Application
  Open Application  http://localhost:4723/wd/hub  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
  ...  app=${ANDROID_APP}  appPackage=com.example.cow_mange    appActivity=.MainActivity

go to Page 
    Click Element    ${vbc_manu}
    Click Element    ${vbc_manu2}
    Click Element    ${vbc_own}
    Click Element    ${vb_Rg}  
    Sleep  3s

Input Text page     
    [Arguments]     ${Prefix}    ${Name}    ${Lname}    ${us}    ${pw}    ${email}    ${phone}
    # เพศ
    Wait Until Page Contains Element  ${sn_Gander}   10s
    Click Element    ${sn_Gander}
    IF    '${Prefix}' == 'นาง' 
        Wait Until Page Contains Element    ${sn_g1}    10s
        Click Element    ${sn_g1}
        Sleep    1s
    ELSE IF  '${Prefix}' == 'นาย' 
        Wait Until Page Contains Element    ${sn_g2}   10s
        Click Element    ${sn_g2}
        Sleep    1s
    ELSE
        Wait Until Page Contains Element    ${sn_g3}   10s
        Click Element    ${sn_g3}
        Sleep    1s
    END
        Click Element    ${vt_Name}    
        Input Text    ${vt_Name}  ${Name}
        Sleep  2s
        Click Element    ${vt_LName}    
        Input Text    ${vt_LName}    ${Lname}
        Sleep  2s 
        Click Element    ${vt_us}   
        Input Text    ${vt_us}     ${us}
        Sleep  2s  
        Click Element    ${vt_pass}    
        Input Text    ${vt_pass}     ${pw} 
        Sleep  2s 
        Click Element    ${vt_email}    
        Input Text    ${vt_email}     ${email} 
        Sleep  2s
        Click Element    ${vt_phone}   
        Input Text    ${vt_phone}    ${phone}
        Swipe By Percent	50	90	50	20	4000
        Swipe By Percent	50	90	50	20	4000
        Sleep    5s

# ที่อยู่

Input farm
    [Arguments]    ${Fname}    ${Ftype}  
    Click Element    ${vt_Fname}    
    Input Text    ${vt_Fname}  ${Fname}
    Wait Until Page Contains Element  ${sn_Ftype}   10s
    Click Element    ${sn_Ftype}
    IF    '${Ftype}' == 'บริษัท' 
        Wait Until Page Contains Element    ${sn_Ftype1}    10s
        Click Element    ${sn_Ftype1}
        Sleep    1s
    ELSE IF  '${Ftype}' == 'ประกัน' 
        Wait Until Page Contains Element    ${sn_Ftype2}   10s
        Click Element    ${sn_Ftype2}
        Sleep    1s
    ELSE IF  '${Ftype}' == 'ราชการ' 
        Wait Until Page Contains Element    ${sn_Ftype3}   10s
        Click Element    ${sn_Ftype3}
        Sleep    1s
    ELSE IF  '${Ftype}' == 'อิสระ' 
        Wait Until Page Contains Element    ${sn_Ftype4}   10s
        Click Element    ${sn_Ftype4}
        Sleep    1s
    ELSE
        Wait Until Page Contains Element    ${sn_Ftype5}   10s
        Click Element    ${sn_Ftype5}
        Sleep    1s
    END

# รูป
# Choose Pic
#     [Arguments]  ${PF}
#     IF   '${PF}' == 'Dogpf.jpg'
#         Wait Until Page Contains Element  ${CHOOSE_FILE}  10s
#         Click Element  ${CHOOSE_FILE} 
#         Wait Until Page Contains Element  ${SELECT_PIC}
#         Click Element  ${SELECT_PIC}
#         Wait Until Page Contains Element  //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:02:15 AM"]  10s
#         Click Element   //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:02:15 AM"]
#    # Wait Until Page Contains Element  ${BACK_PIC}
#    # Click Element  ${BACK_PIC}

#     ELSE IF  '${PF}' == 'Dogpf.png'
#         Wait Until Page Contains Element  ${CHOOSE_FILE}  10s
#         Click Element  ${CHOOSE_FILE} 
#         Wait Until Page Contains Element  ${SELECT_PIC}
#         Click Element  ${SELECT_PIC}
#         Wait Until Page Contains Element   //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 3:59:39 AM"]  10s
#         Click Element    //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 3:59:39 AM"] 
#    # Wait Until Page Contains Element  ${BACK_PIC}
#    # Click Element  ${BACK_PIC}

#     ELSE IF  '${PF}' == 'Dogpf.jpg 1 MB'
#         Wait Until Page Contains Element  ${CHOOSE_FILE}  10s
#         Click Element  ${CHOOSE_FILE} 
#         Wait Until Page Contains Element  ${SELECT_PIC}
#         Click Element  ${SELECT_PIC}
#         Wait Until Page Contains Element   //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:08:11 AM"]  10s 
#         Click Element    //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:08:11 AM"]
#    # Wait Until Page Contains Element  ${BACK_PIC}
#    # Click Element  ${BACK_PIC}
    
#     ELSE IF  '${PF}' == 'Dogpf.jpg 2 MB'
#         Wait Until Page Contains Element  ${CHOOSE_FILE}  10s
#         Click Element  ${CHOOSE_FILE} 
#         Wait Until Page Contains Element  ${SELECT_PIC}
#         Click Element  ${SELECT_PIC}
#         Wait Until Page Contains Element   //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:08:44 AM"]  10s
#         Click Element     //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:08:44 AM"]
#    # Wait Until Page Contains Element  ${BACK_PIC}
#    # Click Element  ${BACK_PIC}
    
#     ELSE IF  '${PF}' == 'Dogpf.jpg 3 MB'
#         Wait Until Page Contains Element  ${CHOOSE_FILE}  10s
#         Click Element  ${CHOOSE_FILE} 
#         Wait Until Page Contains Element  ${SELECT_PIC}
#         Click Element  ${SELECT_PIC}
#         Wait Until Page Contains Element   //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:24:06 AM"]   10s
#         Click Element     //android.view.ViewGroup[@content-desc="Photo taken on Nov 9, 2022 4:24:06 AM"]
#    # Wait Until Page Contains Element  ${BACK_PIC}
#    # Click Element  ${BACK_PIC}

#     END
