*** Settings ***
Library    RequestsLibrary
Library    random
Library    String
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
Library    BuiltIn
Library    DateTime
Library    Selenium2Library
Library    BuiltIn

Library     ${EXECDIR}/Library/connect_mysql.py
Resource    ${EXECDIR}/Resource/Variables/Variables.robot
Resource    ${EXECDIR}/Resource/Keywords/Util.robot

Resource    ${EXECDIR}/Resource/Keywords/API_transfer_amount.robot

