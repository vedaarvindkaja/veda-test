<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>TR1__Close_Job</fullName>
        <field>TR1__Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Close Job</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>TR1__VMS%3A Close Job</fullName>
        <actions>
            <name>TR1__Close_Job</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Job__c.TR1__VMS_Req_ID__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>TR1__Job__c.TR1__VMS_Status__c</field>
            <operation>equals</operation>
            <value>Closed,Filled,Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>TR1__Job__c.TR1__Status__c</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Closed VMS Job based on VMS Status</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
