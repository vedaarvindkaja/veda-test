<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_email_alert_on_expense_reject</fullName>
        <description>Send email alert on expense reject</description>
        <protected>false</protected>
        <recipients>
            <field>TR1__Consultant__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_On_Expense_Reject</template>
    </alerts>
    <alerts>
        <fullName>Send_email_alert_when_expense_is_submitted</fullName>
        <description>Send email alert when expense is submitted</description>
        <protected>false</protected>
        <recipients>
            <field>Approver_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_for_submitted_expense_report</template>
    </alerts>
    <rules>
        <fullName>Send email when expense report is rejected</fullName>
        <actions>
            <name>Send_email_alert_on_expense_reject</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Expense_Report__c.TR1__Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send email when expense report is submitted</fullName>
        <actions>
            <name>Send_email_alert_when_expense_is_submitted</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Expense_Report__c.TR1__Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
