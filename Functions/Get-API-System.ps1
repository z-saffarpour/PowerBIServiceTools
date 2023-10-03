<#
https://app.swaggerhub.com/apis/microsoft-rs/PBIRS/2.0#/system/Getsystem
#>
function Get-RsSystem {
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $true)]
        $ReportRestAPIURI,
        [System.Management.Automation.PSCredential]
        $Credential,
        $ErrorFile
    )
    Begin {
        try {
            $mySystemAPI = $ReportRestAPIURI + '/api/v2.0/system'
            if ($null -ne $Credential) {
                $myResponse = Invoke-RestMethod -Method Get -Uri $mySystemAPI -Credential $Credential -ContentType 'application/json; charset=unicode' -Verbose:$false
            }
            else {
                $myResponse = Invoke-RestMethod -Method Get -Uri $mySystemAPI -UseDefaultCredentials -ContentType 'application/json; charset=unicode' -Verbose:$false
            }
            $myResultJSON = $myResponse.value | ConvertTo-Json -Depth 15   
            return , $myResultJSON 
        }
        catch {
            if ($null -ne $ErrorFile -and $ErrorFile.Length -gt 0) {
                "Function : Get-RsSystem" >> $ErrorFile
                $_ >> $ErrorFile  
                $mySpliter = ("--" + ("==" * 70))
                $mySpliter >> $ErrorFile 
            }
        } 
    }
}