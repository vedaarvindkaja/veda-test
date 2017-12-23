<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>TR1__New_application_email</fullName>
        <description>New application email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TR1__Job_Manager_Templates/TR1__New_Application_Notification_Email</template>
    </alerts>
    <rules>
        <fullName>TR1__Application Rejection - Contact Owner</fullName>
        <active>false</active>
        <criteriaItems>
            <field>TR1__Application__c.TR1__Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TR1__Contact owner will notify</fullName>
        <active>false</active>
        <criteriaItems>
            <field>TR1__Application__c.TR1__Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>TR1__Application__c.TR1__Rejection_Notification__c</field>
            <operation>equals</operation>
            <value>Contact Owner Will Notify</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TR1__New Application Notification Email</fullName>
        <actions>
            <name>TR1__New_application_email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TR1__Application__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>TR1__Update Applicant Owner Email</fullName>
        <active>false</active>
        <criteriaItems>
            <field>TR1__Application__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Application</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
