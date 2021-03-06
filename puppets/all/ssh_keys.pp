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
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6zq796rc6U6fDE+uVnYYL54tR3ndfs/V7tzjz+aEw01U6yN7pNW54DAp1eIg9eU7gEgIJRYTipYJf1hE6qQSqS1fogIKeStknjQ3YL+VbGcEBk88dr9QrX7larYfne7qo50Omv8p/02Hh0Ho4xIeTHmSKkuZQIpIjZ3ktjBtXVN/sgv0jpz2MpNP2k5tsQfXVlhFLVqekt44J7zg6YcaUv4QXIPXbRt5pm4DqfVDAsk8JU7mdiVyamXBbV1zhsU+Lr1Rsla4Y4qxk65hsr0b8IyXBOYu3GbXitjFVAGgpeKIYY36dR/xlvVUb4CLwsbRMNIFa3JtApVt17ck8Qzy3Q== nkolomeitsev@MSK-1370
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCic6HMmTYsXY9NJA375WiQcING0n9N030cbjWa78ggGz5jB5awwpqInTpbobz0TmlPxCDb/PSwvFxHBP6p3ObYpXk8FhzxPBFsQQyD0sCG9z4kfDvZFXV2XXF0+1YmmraGTThwITiupGJ2JqJGUxaqgkb92XC8v6/WqsKDEstaIaeS2IOolntZavbfWviMiYBQWXc+83xgZVByaMWAP+AzcMlArxV8Jj12lXQ1EVkOrjGoUojpT1x8rhxhAOwaxP82lQn9FPZpJtYnOe9B+eo0oJ9wsKLxZCj4hndtRLQyzoy6yUwWnA91+1J/csN7TSMXwKbAI/0eQIQJAWZhxzz7 root@gluk
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZV3LYTQGwqX3bTulT3nQsC5jtmQRDfIyb7cWy3OWkOHkwiAdpjycJmvEJqiaPJ8J7tMCzivtAZNgLfoYigpPo6ovxFM46IimNWCWEKcbqSB0Tmu9Y7EN3DVfdOJ/eIQoL9sX1xxrWPx/QKz4SWg5FlRd4FiN78/zJONW386AlsKvvJWkllZgcwHP5Pg0xyi38VDTgR1EirOdg+mOTBba3QMnyYk4V3DUgvMlb4LOrpuV0ecSRuk1rrQOIyZEzvoawNht8Q+LicJDrnr8yD7HKJmT/OrLNL/FDdl9I9BQo0u4TmVLv3DQmAhxGmrJUq6MB5jKG23llHQW1M6FrRGwR root@kalyan00-desktop
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB0ovO9K6n99tUyihiY5N+E+C2xsquJwqHn7RPsMqPU+J3zb6+mvZRBGeHT1xwcw+KHp4ln64Y6eKZb1OXHTeDXnQJbMW19kiS/Hath1SmFDNT8Fl2/GL5oTfpWJUotU3K1Xr96zBd9dZtPuQIZxH+BDoXWh3GC/iwyVkxLF4OxMw== rsa-key-20140613
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/4aCAMtvcCDuHL8a4zB4imsPiszOOjoumD60SQ6UNNPOPSqjKegVcbJrZESUleqWT3Hu/5PA9AqezDtwENcb9Sb5N+zXRbSP8aAFQUPRTNXJvVCxlpWrJQqQd3KUgvEqf5xPWr2nh0FhpgiigcUhgupT/9lCCkCMULJEImc7e2WMNPW1DjUfabycyxYqxmHrmR+6UCwaprBtnAQQ3ogfD3mn3ua+BV/EKE+z3xusO72Z5ALSYYcRSvENs9d6It3FFi1kyYn6FMZoBtRkH27hqaNzLcnhQliJSzBwZIkDJB0f995PtpKIo2Hp+UuXuCG8+HgsVAvyc+IgGh0UOtLVB root@kalyan00-desktop

', '\x0d', '', 'G'),
    mode    => 0600, 
    owner   => 'root',
    group   => 'root'  
}
