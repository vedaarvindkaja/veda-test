<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Attendence_End_Date_text_field</fullName>
        <field>TR1__EndDate__c</field>
        <formula>IF(ISNULL(RC_Attendance_End_Date__c) , &apos;&apos; , TEXT(MONTH(RC_Attendance_End_Date__c))+&quot;/&quot; +TEXT(DAY(RC_Attendance_End_Date__c))+&quot;/&quot; +TEXT(YEAR(RC_Attendance_End_Date__c)))</formula>
        <name>Update Attendence End Date text field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Attendence_Start_Date_text_field</fullName>
        <field>TR1__StartDate__c</field>
        <formula>IF(ISNULL(RC_Attendance_Start_Date__c) , &apos;&apos; , TEXT(MONTH(RC_Attendance_Start_Date__c))+&quot;/&quot; +TEXT(DAY(RC_Attendance_Start_Date__c))+&quot;/&quot; +TEXT(YEAR(RC_Attendance_Start_Date__c)))</formula>
        <name>Update Attendence Start Date text field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Degree_Date_text_field</fullName>
        <field>TR1__DegreeDate__c</field>
        <formula>IF(ISNULL(RC_Degree_Date__c) , &apos;&apos; , TEXT(MONTH(RC_Degree_Date__c))+&quot;/&quot; +TEXT(DAY(RC_Degree_Date__c))+&quot;/&quot; +TEXT(YEAR(RC_Degree_Date__c)))</formula>
        <name>Update Degree Date text field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Education Start_End and Degree Date text field</fullName>
        <actions>
            <name>Update_Attendence_End_Date_text_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Attendence_Start_Date_text_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Degree_Date_text_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>To convert the Start, End and Degree date field value to Start, End and Degree text field</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
