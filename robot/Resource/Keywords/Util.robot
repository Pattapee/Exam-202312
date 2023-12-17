*** Keywords ***
Function Get Current Date
    ${now}=            Get Current Date    time_zone=UTC
    ${date}=           Add Time To Date    ${now}           7 hours
    ${convertDate}=    Convert Date        ${date}          result_format=%Y-%m-%dT%H:%M:%S    exclude_millis=true

    [Return]    ${convertDate}

Function Get Current Date By Custom Format
    [Arguments]    ${format}

    ${now}=            Get Current Date    time_zone=UTC
    ${date}=           Add Time To Date    ${now}           7 hours
    ${convertDate}=    Convert Date        ${date}          result_format=${format}    exclude_millis=true

    [Return]    ${convertDate}

Function Get Date With Add Days
    [Arguments]    ${days}

    ${now}=            Get Current Date    time_zone=UTC
    ${date}=           Add Time To Date    ${now}           ${days} days
    ${date}=           Add Time To Date    ${date}          7 hours
    ${convertDate}=    Convert Date        ${date}          result_format=%Y-%m-%dT%H:%M:%S    exclude_millis=true

    [Return]    ${convertDate}

Function Get Date With Add Days by Custom Format
    [Arguments]    ${days}    ${format}

    ${now}=            Get Current Date    time_zone=UTC
    ${date}=           Add Time To Date    ${now}           ${days} days
    ${date}=           Add Time To Date    ${date}          7 hours
    ${convertDate}=    Convert Date        ${date}          result_format= ${format}    exclude_millis=true

    [Return]    ${convertDate}

Function Get Date With Subtract Days
    [Arguments]    ${days}

    ${now}=            Get Current Date           time_zone=UTC
    ${date}=           Subtract Time From Date    ${now}           ${days} days
    ${date}=           Add Time To Date           ${date}          7 hours
    ${convertDate}=    Convert Date               ${date}          result_format=%Y-%m-%dT%H:%M:%S    exclude_millis=true

    [Return]    ${convertDate}

Function Get uuid
    ${uuid}=    Evaluate             uuid.uuid4()    modules=uuid
    ${uuid}=    Convert to String    ${uuid}

    [Return]    ${uuid}


