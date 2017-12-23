<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>TR1__Notify_On_Resume_Uploaded_Successfully</fullName>
        <description>Notify Resume Parsed Successfully</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TR1__Talent_Rover_Email_Templates/TR1__Successful_Resume_Upload</template>
    </alerts>
    <rules>
        <fullName>TR1__Successful File Sync Upload</fullName>
        <actions>
            <name>TR1__Notify_On_Resume_Uploaded_Successfully</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Emails User when Parsing Successful</description>
        <formula>ISCHANGED( TR1__Last_Mass_Resume_Upload__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
