<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Hours_Accrued</fullName>
        <description>No of hours accured on a timesheet approval</description>
        <field>TR1__Hours_Accrued__c</field>
        <formula>IF 
( 
CONTAINS(TR1__Comments__c, &apos;Accrued hours for week ending&apos;), BLANKVALUE(TR1__Hours_Accrued__c ,0)+ 4.864,TR1__Hours_Accrued__c 
)</formula>
        <name>Hours Accrued</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Contact Accrual hours</fullName>
        <actions>
            <name>Hours_Accrued</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Contact_Accrual__c.TR1__Effective_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
