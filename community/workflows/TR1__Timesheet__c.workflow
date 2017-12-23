<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Mail_to_approver_on_timesheet_submit</fullName>
        <description>Mail to approver on timesheet submit</description>
        <protected>false</protected>
        <recipients>
            <field>TR1__Approver__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>TR1__Timesheet_Second_Approver__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Timesheet_Submittal</template>
    </alerts>
    <alerts>
        <fullName>Send_email_notification_to_Timesheet_consultant_for_rejected_Timesheet</fullName>
        <description>Send email notification to Timesheet consultant for rejected Timesheet</description>
        <protected>false</protected>
        <recipients>
            <field>TR1__Consultant__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Communities_Notify_for_rejected_Timesheet</template>
    </alerts>
    <fieldUpdates>
        <fullName>TR1__W2_Calculates_Taxes</fullName>
        <field>TR1__Burden__c</field>
        <formula>(  TR1__Pay_Rate__c  *  TR1__Total_Regular_Hours__c *0.14)+(TR1__Pay_Rate__c  *1.5 * TR1__Total_Overtime_Hours__c *0.14)+(TR1__Pay_Rate__c*2*  TR1__Total_Double_Time_Hours__c  *0.14)</formula>
        <name>W2 Calculates Taxes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>true</protected>
    </fieldUpdates>
    <rules>
        <fullName>Send email notification whenever Timesheet is rejected</fullName>
        <actions>
            <name>Send_email_notification_to_Timesheet_consultant_for_rejected_Timesheet</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Timesheet__c.TR1__Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <description>Evaluate the rule when a record is created, and any time it’s edited to subsequently meet criteria</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TR1__W2 Calculates Burden</fullName>
        <actions>
            <name>TR1__W2_Calculates_Taxes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Timesheet__c.TR1__Payroll_Type__c</field>
            <operation>notContain</operation>
            <value>1099</value>
        </criteriaItems>
        <description>Calculates payroll taxes when Payroll Type contains W.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Timesheet Submittal</fullName>
        <actions>
            <name>Mail_to_approver_on_timesheet_submit</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Timesheet__c.TR1__Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <description>When candidate submit a timesheet, send mail to approval</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
