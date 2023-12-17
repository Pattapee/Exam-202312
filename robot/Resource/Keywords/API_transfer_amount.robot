*** Keywords ***
Request API Transfer Amount
    [Arguments]    ${payload}

    Create Session    API_Transfer       ${baseurl['${ENV}']}    timeout=30000           verify=true
    ${response}=      POST On Session    API_Transfer            ${endpoint_transfer}    json=${payload}    expected_status=anything

    [Return]    ${response}