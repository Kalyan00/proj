file { '/root/.ssh':
    ensure  => directory,
    owner   => 'root',
    group   => 'root'  
}


file { '/root/.ssh/authorized_keys':
    ensure  => present,         
    content =>  regsubst('
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA4UvFheIzDi52Yka5UEJD+yjkTvbATIy/lifu1RaBZR0Bsx95AIgMFVYtq4O+RchljR1+vo5OTDKUsOoPS1vh8cmeZvaye4/xNKszBi816YeSsw4ireyMKrm/WcECFsxw93O7APY7jGdaMeopuQx2E0tehU/1H+aZ2SRdJ8G9cTY5+EOo/kMEBsRU32yfsAfYml87cAaH4MrGSqhQQ4yrvJJc5xmHNs8nBT1xA8Rgoqa/r+bf9/NAX3ETBqST+LyInjCToNtg45eMdTk4ndaauPmXsH+cvNgdvja183OEI0qK9XMAg5Z2fTcQX4WgpBAfukmRfmifo26qm9cbY7YZcw== root@wc
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDLNc8MvVhmjBzYMQAjS9eSeBzYyPXspgfQTMmET4sBc4S+mVJt+M29FVZ4XQJf7iNwPAk64EShGDTnGrSQHDMvPuAqkFS4S+64xe2JZErXOpN3Bd3ArZDds5xSZQMIeizAxHB76u6/EOvNh33zK8lk8wXoTqjpoYEIsCErHWWkYw== Kalyan00Galaxy
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA3xupyPUQH0Lh738LCOaeKf/RDIXPCcmluiOGMXJpZCOl7Z1HAY4BsUawbAXCX8sXGeJiT915+YfB5MEhGP+/WTPbeyj65Z3DSXPrtflAuFi57+CGVIuboT20u3EiBtx3cWxy3gySbWRUVN+eCwQPdN3hZxFlnzI4mfQJ56o4lH0= NKolomeitsev@MSK-0069
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCic6HMmTYsXY9NJA375WiQcING0n9N030cbjWa78ggGz5jB5awwpqInTpbobz0TmlPxCDb/PSwvFxHBP6p3ObYpXk8FhzxPBFsQQyD0sCG9z4kfDvZFXV2XXF0+1YmmraGTThwITiupGJ2JqJGUxaqgkb92XC8v6/WqsKDEstaIaeS2IOolntZavbfWviMiYBQWXc+83xgZVByaMWAP+AzcMlArxV8Jj12lXQ1EVkOrjGoUojpT1x8rhxhAOwaxP82lQn9FPZpJtYnOe9B+eo0oJ9wsKLxZCj4hndtRLQyzoy6yUwWnA91+1J/csN7TSMXwKbAI/0eQIQJAWZhxzz7 root@gluk
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZV3LYTQGwqX3bTulT3nQsC5jtmQRDfIyb7cWy3OWkOHkwiAdpjycJmvEJqiaPJ8J7tMCzivtAZNgLfoYigpPo6ovxFM46IimNWCWEKcbqSB0Tmu9Y7EN3DVfdOJ/eIQoL9sX1xxrWPx/QKz4SWg5FlRd4FiN78/zJONW386AlsKvvJWkllZgcwHP5Pg0xyi38VDTgR1EirOdg+mOTBba3QMnyYk4V3DUgvMlb4LOrpuV0ecSRuk1rrQOIyZEzvoawNht8Q+LicJDrnr8yD7HKJmT/OrLNL/FDdl9I9BQo0u4TmVLv3DQmAhxGmrJUq6MB5jKG23llHQW1M6FrRGwR root@kalyan00-desktop

', '\x0d', '', 'G'),
    mode    => 0600, 
    owner   => 'root',
    group   => 'root'  
}
