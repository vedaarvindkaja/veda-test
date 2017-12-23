<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_End_Date_text_field</fullName>
        <field>TR1__EndDate__c</field>
        <formula>IF(ISNULL(RC_End_Date__c) , &apos;&apos; , TEXT(MONTH(RC_End_Date__c))+&quot;/&quot; +TEXT(DAY(RC_End_Date__c))+&quot;/&quot; +TEXT(YEAR(RC_End_Date__c)))</formula>
        <name>Update End Date text field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Start_Date_text_field</fullName>
        <field>TR1__StartDate__c</field>
        <formula>IF(ISNULL(RC_Start_Date__c) , &apos;&apos; , TEXT(MONTH(RC_Start_Date__c))+&quot;/&quot; +TEXT(DAY(RC_Start_Date__c))+&quot;/&quot; +TEXT(YEAR(RC_Start_Date__c)))</formula>
        <name>Update Start Date text field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Convert Date to Text field</fullName>
        <actions>
            <name>Update_End_Date_text_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Start_Date_text_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>To convert the Start and End date field value to Start and End date text field</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
