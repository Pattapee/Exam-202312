*** Settings ***
Resource    ${EXECDIR}/Resource/AllSetting.robot

***Keywords***
Check response is happy case
    [Arguments]    ${response}    ${payload}

    ${amount}=               Get Value From Json    ${payload}    $.amount
    ${sendingAccount}=       Get Value From Json    ${payload}    $.sendingAccount
    ${receivingAccount}=     Get Value From Json    ${payload}    $.receivingAccount
    ${receivingBankCode}=    Get Value From Json    ${payload}    $.receivingBankCode

    Should be Equal As Strings    ${response.status_code}                             200
    Should Be True                "${response.elapsed.total_seconds()}" < "0.3000"
    Should be Equal As Strings    ${response.json()['data']['amount']}                ${amount[0]}
    Should be Equal As Strings    ${response.json()['data']['sendingAccountNo']}      ${sendingAccount[0]}
    Should be Equal As Strings    ${response.json()['data']['receivingAccountNo']}    ${receivingAccount[0]}
    Should be Equal As Strings    ${response.json()['data']['receivingBankCode']}     ${receivingBankCode[0]}

    # Check data into database test table transfer_history    ${response}    SUCCESS

Check response by Error message
    [Arguments]    ${response}    ${error_message}    ${http_status_code}

    Should be Equal As Strings    ${response.status_code}                   ${http_status_code}
    Should be Equal As Strings    ${response.json()['error']['message']}    ${error_message}

    # Check data into database test table transfer_history    ${response}    ${error_message}

Check data into database test table transfer_history
    [Arguments]    ${response}    ${message}

    ${res_query}=    connGetPostgres    select th.id, th.sending_account, th.receiving_account, th.amount, th.resp_message, th.transfer_ref_id from test.transfer_history th where 1=1 and th.transfer_ref_id = '${${response.json()['data']['transferReferenceID']}}'

    Should be Equal As Strings    ${response.json()['data']['sendingAccountNo']}       ${res_query[1]}
    Should be Equal As Strings    ${response.json()['data']['receivingAccountNo']}     ${res_query[2]}
    Should be Equal As Strings    ${response.json()['data']['receivingBankCode']}      ${res_query[3]}
    Should be Equal As Strings    ${message}                                           ${res_query[4]}
    Should be Equal As Strings    ${response.json()['data']['transferReferenceID']}    ${res_query[5]}

***Test Cases***
Test transfer money with happy case
    [Documentation]     happycase
    [Tags]    robot:continue-on-failure    happycase    regressiontest

    ${payload}=    Load JSON From File            ${EXECDIR}\\Resource\\Datatest\\transfer.json    encoding=UTF-8
    ${resp}=       Request API Transfer Amount    ${payload}

    Check response is happy case    ${resp}    ${payload}

TC8 - Test transfer money by amount is more than 20 million /day/person
    [Documentation]     expect error response msg='TRANSACTION_LIMIT_DAILY'
    [Tags]    robot:continue-on-failure    TC8    regressiontest

    ${payload}=    Load JSON From File    ${EXECDIR}\\Resource\\Datatest\\transfer.json    encoding=UTF-8

    ${amount}=     Evaluate                       round(20000000.00, 2)
    ${payload}=    Update Value To Json           ${payload}               $.amount    ${amount}
    ${resp}=       Request API Transfer Amount    ${payload}

    Check response by Error message    ${resp}    TRANSACTION_LIMIT_DAILY    500

TC9 - Test transfer money by amount is more than 1 million /transection
    [Documentation]     expect error response msg='TRANSACTION_LIMIT'
    [Tags]    robot:continue-on-failure    TC9    regressiontest

    ${payload}=    Load JSON From File    ${EXECDIR}\\Resource\\Datatest\\transfer.json    encoding=UTF-8

    ${amount}=     Evaluate                       round(1000000, 2)
    ${payload}=    Update Value To Json           ${payload}           $.amount    ${amount}
    ${resp}=       Request API Transfer Amount    ${payload}

    Check response by Error message    ${resp}    TRANSACTION_LIMIT    500

TC15 - Test transfer money by amount = 0.01
    [Documentation]     success response and http status code 200
    [Tags]    robot:continue-on-failure    TC15    regressiontest

    ${payload}=    Load JSON From File            ${EXECDIR}\\Resource\\Datatest\\transfer.json    encoding=UTF-8
    ${amount}=     Evaluate                       round(0.01, 2)
    ${payload}=    Update Value To Json           ${payload}                                       $.amount          ${amount}
    ${resp}=       Request API Transfer Amount    ${payload}

    Check response is happy case    ${resp}    ${payload}

TC29 - Test Validate req field sendingAccount is null
    [Documentation]     error response msg ='BAD_REQUEST'
    [Tags]    robot:continue-on-failure    TC28    regressiontest

    ${payload}=    Load JSON From File    ${EXECDIR}\\Resource\\Datatest\\transfer.json    encoding=UTF-8

    ${payload}=    Update Value To Json           ${payload}    $.amount    ${None}
    ${resp}=       Request API Transfer Amount    ${payload}

    Check response by Error message    ${resp}    BAD_REQUEST    400

TC31 - Test Validate req field sendingAccount is data in 26 characters
    [Documentation]     success response and http status code 200
    [Tags]    robot:continue-on-failure    TC31    regressiontest

    ${payload}=    Load JSON From File    ${EXECDIR}\\Resource\\Datatest\\transfer.json    encoding=UTF-8

    ${sendingAccount}    Generate Random String         26            [STRING]
    ${payload}=          Update Value To Json           ${payload}    $.sendingAccount    ${sendingAccount}
    ${response}=         Request API Transfer Amount    ${payload}

    ${amount}=               Get Value From Json    ${payload}    $.amount
    # SKIP because mockAPI response constant value
    # ${sendingAccount}=       Get Value From Json    ${payload}    $.sendingAccount
    ${receivingAccount}=     Get Value From Json    ${payload}    $.receivingAccount
    ${receivingBankCode}=    Get Value From Json    ${payload}    $.receivingBankCode

    Should be Equal As Strings    ${response.status_code}                             200
    Should Be True                "${response.elapsed.total_seconds()}" < "0.3000"
    Should be Equal As Strings    ${response.json()['data']['amount']}                ${amount[0]}
    # SKIP because mockAPI response constant value
    # Should be Equal As Strings    ${response.json()['data']['sendingAccountNo']}      ${sendingAccount[0]}
    Should be Equal As Strings    ${response.json()['data']['receivingAccountNo']}    ${receivingAccount[0]}
    Should be Equal As Strings    ${response.json()['data']['receivingBankCode']}     ${receivingBankCode[0]}

