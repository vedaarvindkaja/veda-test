<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Per_Diem</fullName>
        <field>TR1__Amount__c</field>
        <formula>if(!ISBLANK(TR1__Rate__r.TR1__RatePay__c) &amp;&amp; RecordType.DeveloperName=&apos;Per_Diem&apos; ,TR1__Rate__r.TR1__RatePay__c,TR1__Miles__c * Mileage_Rate__c)</formula>
        <name>Per Diem and Mileage Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Mileage and per diem amount</fullName>
        <actions>
            <name>Per_Diem</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(
   RecordType.DeveloperName=&apos;Per_Diem&apos;,
   RecordType.DeveloperName=&apos;Mileage&apos;
 )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
