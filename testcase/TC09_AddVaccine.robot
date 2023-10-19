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
${vb_manu}    xpath=//android.widget.Button[@index='0'[2]]

${bt_add}    xpath=//android.widget.Button[@content-desc="เพิ่มข้อมูลการฉีดวัคซีน"]
${sn_Nvicc}    xpath=//android.widget.Button[@content-desc="ชื่อวัคซีน"]
${sn_Nvicc1}    xpath=//android.view.View[@content-desc="วัคซีนบรูเซลโลซีส --------------"]
${sn_Nvicc2}    xpath=//android.view.View[@content-desc="วัคซีนแบลคเลก --------------"]
${sn_Nvicc3}		xpath=//android.view.View[@content-desc="วัคซีนโรคปากและเท้าเปื่อยสำหรับโค - กระบือ --------------"]
${sn_Nvicc4}		xpath=//android.view.View[@content-desc="วัคซีนแอนแทรกซ์ --------------"]
${sn_Nvicc5}    xpath=//android.view.View[@content-desc="วัคซีนเฮโมรายิกเซพติซีเมีย --------------"]

${sn_foodT}		xpath=//android.widget.Button[@index='6']
${sn_foodT1}		xpath=//android.view.View[@content-desc="-"]
${sn_foodT2}		xpath=//android.view.View[@content-desc="ร็อคโก้ "]
${sn_foodT3}		xpath=//android.view.View[@content-desc="แร่ธาตุก้อน SK "]

${add_data}    xpath=//android.view.View[@content-desc="เพิ่มข้อมูลการให้อาหารโค"]

${testcaseData} 
${Status} 

*** Test Cases ***
TC09_AddVaccine
    # Start Video Recording    name=D:/robot_pjtest/results/TC09_AddVaccine/video/TC09_AddVaccine  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1    
    Open Excel Document    D:/robot_pjtest/testdata/TC09_AddVaccine.xlsx    doc_id=TestData
    ${excel}    Get Sheet    TestData
    Open Test Application
    LoginPage
    Goto add 
    FOR    ${i}    IN RANGE    2    ${excel.max_row+1}
        ${status_yn}     Set Variable if    '${excel.cell(${i},1).value}'=='None'    ${Empty}     ${excel.cell(${i},1).value}
        IF    "${status_yn}" == "Y"
            
            ${tcid}     Set Variable if    '${excel.cell(${i},2).value}'=='None'    ${Empty}     ${excel.cell(${i},2).value}
            Set Suite Variable   ${testcaseData}  ${tcid}
            ${Nvaccine}     Set Variable if    '${excel.cell(${i},3).value}'=='None'    ${Empty}     ${excel.cell(${i},3).value}
            ${Date}     Set Variable if    '${excel.cell(${i},4).value}'=='None'    ${Empty}     ${excel.cell(${i},4).value}
            ${RD}     Set Variable if    '${excel.cell(${i},5).value}'=='None'    ${Empty}     ${excel.cell(${i},5).value}
            
            Name vaccine    ${Nvaccine} 
           
        END
        
    END                                                    
    Save Excel Document    D://robot_pjtest//results//TC09_AddVaccine//WriteExcel//TC09_AddVaccine_Result.xlsx
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
    Click Element    ${sn_Nvicc}
    Sleep    2s
Name vaccine
    [Arguments]    ${Nvaccine} 

    # Wait Until Page Contains Element    ${sn_Nvicc}   10s

    IF    '${Nvaccine} ' == 'วัคซีนบรูเซลโลซีส' 
        Wait Until Page Contains Element    ${sn_Nvicc1}    10s
        Click Element    ${sn_Nvicc1}
        Sleep    1s
    ELSE IF  '${Nvaccine}' == 'วัคซีนแบลคเลก' 
        Wait Until Page Contains Element    ${sn_Nvicc2}  10s
        Click Element    ${sn_Nvicc2}
        Sleep    1s
    ELSE IF  '${Nvaccine}' == 'วัคซีนโรคปากและเท้าเปื่อยสำหรับโค - กระบือ' 
         Wait Until Page Contains Element    ${sn_Nvicc3}  10s
        Click Element    ${sn_Nvicc3}
    ELSE IF  '${Nvaccine}' == 'วัคซีนแอนแทรกซ์' 
        Wait Until Page Contains Element    ${sn_Nvicc4}  10s
        Click Element    ${sn_Nvicc4}
    ELSE IF  '${Nvaccine}' == 'วัคซีนเฮโมรายิกเซพติซีเมีย' 
        Wait Until Page Contains Element    ${sn_Nvicc5}  10s
        Click Element    ${sn_Nvicc5}
    END
    Sleep  3s
    

