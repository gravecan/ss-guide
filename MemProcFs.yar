/*
  Memory-oriented YARA rules for MemProcFS forensic YARA scanning.
  Design goals:
  - no external globals such as filepath
  - no file-only heuristics such as overlay or section-only PE checks
  - avoid API-only rules that match normal export tables in system DLLs
  - prefer low-FP text clusters and strict PE-aware detections
*/

import "pe"
import "dotnet"
import "math"

private rule _mpfs_valid_pe_header {
  condition:
    filesize > 512 and
    uint16(0) == 0x5A4D and
    uint32(uint32(0x3C)) == 0x00004550
}

private rule _MEMPROCFS_NOISE_RULE_TEXT {
  strings:
    $a = "rule " ascii nocase
    $b = "meta:" ascii nocase
    $c = "strings:" ascii nocase
    $d = "condition:" ascii nocase
    $e = ".yar" ascii nocase
    $f = "description =" ascii nocase
    $g = "author =" ascii nocase
    $h = "import \"pe\"" ascii
    $i = "import \"math\"" ascii
    $j = "ascii wide nocase" ascii
    $k = "fullword" ascii nocase
    $l = "nocase" ascii nocase

  condition:
    3 of them
}

private rule _MEMPROCFS_NOISE_SESSION_LOG {
  strings:
    $a = ".codex\\sessions\\" ascii nocase
    $b = "rollout-" ascii nocase
    $c = "\"call_id\":" ascii
    $d = "\"timeout_ms\":" ascii
    $e = "\"analysis\":" ascii
    $f = "screenshare-tool-main" ascii nocase
    $g = "minecraft_anticheat" ascii nocase
    $h = "analysis_report.json" ascii nocase

  condition:
    2 of them
}

private rule _MEMPROCFS_NOISE_CODEX_SESSION {
  strings:
    $a = "\"type\":\"session_meta\"" ascii
    $b = "\"type\":\"response_item\"" ascii
    $c = "\"originator\":\"Codex Desktop\"" ascii
    $d = "\"role\":\"developer\"" ascii
    $e = "\"role\":\"assistant\"" ascii
    $f = "\"function_call_output\"" ascii
    $g = "\"call_id\":\"call_" ascii
    $h = "\"name\":\"shell_command\"" ascii
    $i = "\"recipient_name\":\"functions.shell_command\"" ascii

  condition:
    3 of them
}

private rule _MEMPROCFS_NOISE_ANALYSIS_JSON {
  strings:
    $a = "\"sha256\":" ascii
    $b = "\"file_entropy\":" ascii
    $c = "\"magic_type\":" ascii
    $d = "\"binary_tokens\":" ascii
    $e = "\"ascii_strings_sample\":" ascii
    $f = "\"text_preview\":" ascii
    $g = "\"section_count\":" ascii
    $h = "\"high_entropy_sections\":" ascii
    $i = "\"masquerade\":" ascii

  condition:
    4 of them
}

private rule _MEMPROCFS_NOISE_SELF_TOOLING {
  strings:
    $a = "C:\\Users\\jumarf\\Desktop\\moment\\" ascii wide nocase
    $b = "\\Desktop\\moment\\pack\\" ascii wide nocase
    $c = "validate_rules.py" ascii wide nocase
    $d = "MemProcFs.yar" ascii wide nocase
    $e = "yara.yar" ascii wide nocase
    $f = "rules.yar" ascii wide nocase
    $g = "analysis_report.json" ascii wide nocase
    $h = "MemProcFs_pack_legit_" ascii wide nocase
    $i = "MemProcFs_fpcheck_" ascii wide nocase
    $ps = "PowerShellCore%4Operational.evtx" ascii wide nocase

  condition:
    2 of ($a,$b,$c,$d,$e,$f,$g,$h,$i) and not $ps
}

private rule _MEMPROCFS_NOISE_WEB_FILTERLIST {
  strings:
    $a = "###cookie" ascii nocase
    $b = "$image,domain=" ascii nocase
    $c = "$domain=" ascii nocase
    $d = "hwid=" ascii nocase
    $e = "&cid=" ascii nocase
    $f = "utm." ascii nocase
    $g = "#@#" ascii
    $h = "$script" ascii nocase

  condition:
    3 of them
}

private rule _MEMPROCFS_NOISE_APP_CACHE {
  strings:
    $a = "Service Worker\\CacheStorage" ascii nocase
    $b = "YandexBrowser\\User Data" ascii nocase
    $c = "Code Cache\\js" ascii nocase
    $d = "app.asar" ascii nocase
    $e = "Run History-1.5a.bac" ascii nocase
    $f = "steamui_english.txt" ascii nocase
    $g = "Kaspersky Lab" ascii nocase

  condition:
    1 of them
}

private rule _MEMPROCFS_NOISE_CONTEXT {
  condition:
    _MEMPROCFS_NOISE_RULE_TEXT or
    _MEMPROCFS_NOISE_SESSION_LOG or
    _MEMPROCFS_NOISE_CODEX_SESSION or
    _MEMPROCFS_NOISE_ANALYSIS_JSON or
    _MEMPROCFS_NOISE_SELF_TOOLING or
    _MEMPROCFS_NOISE_WEB_FILTERLIST or
    _MEMPROCFS_NOISE_APP_CACHE
}

rule MEMPROCFS_KNOWN_CHEAT_BRANDS_TEXT : memprocfs cheat brand {
  meta:
    author = "Jumarf"
    description = "Known cheat brands, pack names, or embedded PDB traces that are stable in memory"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $brand1 = "Exodus.codes" ascii wide nocase
    $brand2 = "slinky.gg" ascii wide nocase
    $brand3 = "vape.gg" ascii wide nocase
    $brand4 = "lithiumclient.wtf" ascii wide nocase
    $brand5 = "discord.gg/advantages" ascii wide nocase
    $dll1 = "slinkyhook.dll" ascii wide nocase
    $dll2 = "slinky_library.dll" ascii wide nocase
    $dll3 = "breeze.dll" ascii wide nocase
    $msg1 = "[!] Failed to find Vape jar" ascii wide nocase
    $msg2 = "Vape Launcher" ascii wide nocase
    $msg3 = "Open Minecraft, then try again." ascii wide nocase
    $msg4 = "Adding delay to Minecraft" ascii wide nocase
    $name1 = "Sapphire LITE Clicker" ascii wide nocase
    $name2 = "Monolith Lite" ascii wide nocase
    $name3 = "UNICORN CLIENT" ascii wide nocase
    $name4 = "UwU Client" ascii wide nocase
    $name5 = "dream-injector" ascii wide nocase
    $name6 = "VROOMCLICKER" ascii wide nocase
    $pdb1 = "C:\\Users\\PC\\Desktop\\Cleaner-main\\obj\\x64\\Release\\WindowsFormsApp3.pdb" ascii wide nocase
    $pdb2 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-external.pdb" ascii wide nocase
    $pdb3 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-internal.pdb" ascii wide nocase
    $pdb4 = "C:\\Users\\DeathZ\\source\\repos\\StarDLL\\x64\\Release\\MoonDLL.pdb" ascii wide nocase
    $pdb5 = "C:\\Users\\mella\\source\\repos\\Fox v2\\x64\\Release\\Fox.pdb" ascii wide nocase
    $pdb6 = "C:\\Users\\hyeox\\Desktop\\imgui-master\\examples\\example_win32_directx9\\Release\\icetea_dx9_final.pdb" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      any of ($pdb*) or
      2 of ($brand*, $dll*, $msg*, $name*)
    )
}

rule MEMPROCFS_MINECRAFT_CLICKER_CONTEXT : memprocfs cheat clicker minecraft {
  meta:
    author = "Jumarf"
    description = "Minecraft clicker context with PvP-specific strings that are likely to persist in process memory"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $base1 = "minecraft" ascii wide nocase
    $base2 = "clicker" ascii wide nocase
    $base3 = "autoclicker" ascii wide nocase
    $ctx1 = "hypixel" ascii wide nocase
    $ctx2 = "lunar client" ascii wide nocase
    $ctx3 = "jitter" ascii wide nocase
    $ctx4 = "butterfly" ascii wide nocase
    $ctx5 = "left cps" ascii wide nocase
    $ctx6 = "right cps" ascii wide nocase
    $ctx7 = "reach" ascii wide nocase
    $ctx8 = "velocity" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      (($base1 and $base2) and 1 of ($ctx*)) or
      ($base3 and 1 of ($ctx*)) or
      (($base1 or $base2) and 2 of ($ctx*))
    )
}

rule MEMPROCFS_CLICKER_SETTINGS_PANEL : memprocfs cheat clicker settings {
  meta:
    author = "Jumarf"
    description = "Clicker settings panels with left/right click, CPS and combat-specific options"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $btn1 = "left click" ascii wide nocase
    $btn2 = "right click" ascii wide nocase
    $btn3 = "leftclick" ascii wide nocase
    $btn4 = "rightclick" ascii wide nocase
    $cfg1 = "cps" ascii wide nocase
    $cfg2 = "randomization" ascii wide nocase
    $cfg3 = "randomizer" ascii wide nocase
    $cfg4 = "blockhit" ascii wide nocase
    $cfg5 = "block hit" ascii wide nocase
    $cfg6 = "autoblock" ascii wide nocase
    $cfg7 = "break blocks" ascii wide nocase
    $cfg8 = "inventory" ascii wide nocase
    $cfg9 = "sword" ascii wide nocase
    $cfg10 = "jitter click" ascii wide nocase
    $cfg11 = "butterfly click" ascii wide nocase
    $cfg12 = "double click" ascii wide nocase
    $cfg13 = "click interval" ascii wide nocase
    $cfg14 = "start clicking" ascii wide nocase
    $cfg15 = "stop clicking" ascii wide nocase
    $cfg16 = "string cleaner" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    2 of ($btn*) and
    $cfg1 and
    1 of ($cfg10,$cfg11,$cfg12,$cfg13,$cfg14,$cfg15,$cfg16) and
    1 of ($cfg2,$cfg3,$cfg4,$cfg5,$cfg6,$cfg7,$cfg8,$cfg9)
}

rule MEMPROCFS_STREAMPROOF_SCREENSHARE_BYPASS : memprocfs bypass screenshare evasion {
  meta:
    author = "Jumarf"
    description = "Screenshare bypass strings that are specific enough for memory hunting"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $ss1 = "streamproof" ascii wide nocase
    $ss2 = "anti screenshot" ascii wide nocase
    $ss3 = "screenshare bypass" ascii wide nocase
    $ss4 = "screen share bypass" ascii wide nocase
    $ss5 = "screenshare tool" ascii wide nocase
    $ss6 = "ss tool" ascii wide nocase
    $ss7 = "hide from screenshare" ascii wide nocase
    $brand1 = "no bypass clicker" ascii wide nocase
    $act1 = "self destruct" ascii wide nocase
    $act2 = "selfdestruct" ascii wide nocase
    $act3 = "hide strings" ascii wide nocase
    $act4 = "delete traces" ascii wide nocase
    $act5 = "clean traces" ascii wide nocase
    $ctx1 = "minecraft" ascii wide nocase
    $ctx2 = "clicker" ascii wide nocase
    $ctx3 = "hypixel" ascii wide nocase
    $ctx4 = "lunar client" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      $brand1 or
      (1 of ($ss*) and 1 of ($act*) and 1 of ($ctx*)) or
      (2 of ($ss*) and 1 of ($ctx*))
    )
}

rule MEMPROCFS_MANUALMAP_INJECTOR_TEXT : memprocfs injector manualmap {
  meta:
    author = "Jumarf"
    description = "Manual-map or injector tooling terms combined with APIs, avoiding export-table-only hits"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $api1 = "CreateRemoteThread" ascii wide nocase
    $api2 = "NtCreateThreadEx" ascii wide nocase
    $api3 = "RtlCreateUserThread" ascii wide nocase
    $api4 = "WriteProcessMemory" ascii wide nocase
    $api5 = "VirtualAllocEx" ascii wide nocase
    $api6 = "LoadLibraryA" ascii wide nocase
    $api7 = "LoadLibraryW" ascii wide nocase
    $api8 = "LdrLoadDll" ascii wide nocase
    $api9 = "QueueUserAPC" ascii wide nocase
    $tool1 = "manual map" ascii wide nocase
    $tool2 = "manualmap" ascii wide nocase
    $tool3 = "reflectiveloader" ascii wide nocase
    $tool4 = "InjectDLL" ascii wide nocase
    $tool5 = "BBInjectDll" ascii wide nocase
    $tool6 = "BlackBone" ascii wide nocase
    $tool7 = "Xenos" ascii wide nocase
    $tool8 = "dll injector" ascii wide nocase
    $tool9 = "shellcode injection" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      (1 of ($tool*) and 2 of ($api*)) or
      2 of ($tool*)
    )
}

rule MEMPROCFS_PROCESS_HOLLOWING_TEXT : memprocfs injector hollowing {
  meta:
    author = "Jumarf"
    description = "Process hollowing or RunPE terminology with supporting thread-context APIs"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $term1 = "process hollowing" ascii wide nocase
    $term2 = "runpe" ascii wide nocase
    $term3 = "run pe" ascii wide nocase
    $term4 = "image hollowing" ascii wide nocase
    $term5 = "process replacement" ascii wide nocase
    $api1 = "SuspendThread" ascii wide nocase
    $api2 = "GetThreadContext" ascii wide nocase
    $api3 = "SetThreadContext" ascii wide nocase
    $api4 = "ResumeThread" ascii wide nocase
    $api5 = "NtUnmapViewOfSection" ascii wide nocase
    $api6 = "ZwUnmapViewOfSection" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    1 of ($term*) and
    3 of ($api*)
}

rule MEMPROCFS_DYNAMIC_API_LOADER_CHEAT : memprocfs loader cheat dynamic_api {
  meta:
    author = "Jumarf"
    description = "Dynamic API resolution combined with explicit cheat-loader terminology"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $api1 = "GetProcAddress" ascii wide nocase
    $api2 = "LoadLibraryA" ascii wide nocase
    $api3 = "LoadLibraryW" ascii wide nocase
    $api4 = "LdrLoadDll" ascii wide nocase
    $api5 = "LdrGetProcedureAddress" ascii wide nocase
    $term1 = "manual map" ascii wide nocase
    $term2 = "manualmap" ascii wide nocase
    $term3 = "reflectiveloader" ascii wide nocase
    $term4 = "dll injector" ascii wide nocase
    $term5 = "shellcode loader" ascii wide nocase
    $term6 = "BlackBone" ascii wide nocase
    $term7 = "BBInjectDll" ascii wide nocase
    $ctx1 = "minecraft" ascii wide nocase
    $ctx2 = "clicker" ascii wide nocase
    $ctx3 = "hypixel" ascii wide nocase
    $ctx4 = "lunar client" ascii wide nocase
    $ctx5 = "autoclicker" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    2 of ($api*) and
    1 of ($term*) and
    1 of ($ctx*)
}

rule MEMPROCFS_CHEAT_AUTH_PANEL : memprocfs cheat auth hwid license {
  meta:
    author = "Jumarf"
    description = "Cheat auth or HWID licensing panel strings without generic whitelist-loader noise"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $auth1 = "hwid" ascii wide nocase
    $auth2 = "license" ascii wide nocase
    $auth3 = "license key" ascii wide nocase
    $auth4 = "keyauth" ascii wide nocase
    $auth5 = "discord.gg" ascii wide nocase
    $auth6 = "webhook" ascii wide nocase
    $auth7 = "subscription" ascii wide nocase
    $auth8 = "activation" ascii wide nocase
    $auth9 = "expiry" ascii wide nocase
    $auth10 = "expires" ascii wide nocase
    $ctx1 = "clicker" ascii wide nocase
    $ctx2 = "autoclicker" ascii wide nocase
    $ctx3 = "minecraft" ascii wide nocase
    $ctx4 = "hypixel" ascii wide nocase
    $ctx5 = "lunar client" ascii wide nocase
    $ctx6 = "jitter click" ascii wide nocase
    $ctx7 = "butterfly click" ascii wide nocase
    $ctx8 = "string cleaner" ascii wide nocase
    $ctx9 = "left cps" ascii wide nocase
    $ctx10 = "right cps" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      ($auth1 and 1 of ($auth2,$auth3,$auth4,$auth7,$auth8,$auth9,$auth10) and 1 of ($ctx*)) or
      (($auth4 or $auth5 or $auth6) and $auth1 and 1 of ($ctx*)) or
      (2 of ($auth*) and 2 of ($ctx*))
    )
}

rule MEMPROCFS_HWID_WEBHOOK_EXFIL_TEXT : memprocfs malware hwid webhook {
  meta:
    author = "Jumarf"
    description = "HWID collection helpers and webhook exfiltration strings seen in loader ecosystems"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $hw1 = "HWID.txt" ascii wide nocase
    $hw2 = "get_local_hwid" ascii wide nocase
    $hw3 = "GetHWID.exe" ascii wide nocase
    $hw4 = "GetHwid" ascii wide nocase
    $hw5 = "copy past your hwid into HWID.txt" ascii wide nocase
    $hw6 = "execute GetHWID.exe" ascii wide nocase
    $web1 = "discord webhook" ascii wide nocase
    $web2 = "webhook" ascii wide nocase
    $web3 = "discord.gg" ascii wide nocase
    $ctx1 = "clicker" ascii wide nocase
    $ctx2 = "minecraft" ascii wide nocase
    $ctx3 = "loader" ascii wide nocase
    $ctx4 = "license" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    2 of ($hw*) and
    1 of ($web*) and
    1 of ($ctx*)
}

rule MEMPROCFS_ENTROPY_DYNAMIC_CHEAT_CHUNK : memprocfs entropy loader injector {
  meta:
    author = "Jumarf"
    description = "High-entropy memory chunk with dynamic loader or injector context"
    target = "MemProcFS process or kernel virtual memory"
    note = "Entropy applies to the currently scanned memory buffer or object chunk"

  strings:
    $api1 = "GetProcAddress" ascii wide nocase
    $api2 = "LoadLibraryA" ascii wide nocase
    $api3 = "LoadLibraryW" ascii wide nocase
    $api4 = "WriteProcessMemory" ascii wide nocase
    $api5 = "VirtualAllocEx" ascii wide nocase
    $api6 = "NtCreateThreadEx" ascii wide nocase
    $tool1 = "manual map" ascii wide nocase
    $tool2 = "manualmap" ascii wide nocase
    $tool3 = "reflectiveloader" ascii wide nocase
    $tool4 = "dll injector" ascii wide nocase
    $tool5 = "shellcode loader" ascii wide nocase
    $tool6 = "BlackBone" ascii wide nocase
    $ctx1 = "minecraft" ascii wide nocase
    $ctx2 = "clicker" ascii wide nocase
    $ctx3 = "hypixel" ascii wide nocase
    $ctx4 = "lunar client" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      (filesize >= 0x20000 and math.entropy(0, 0x20000) >= 7.20) or
      (filesize < 0x20000 and filesize >= 0x4000 and math.entropy(0, filesize) >= 7.20)
    ) and
    3 of ($api*) and
    1 of ($tool*) and
    1 of ($ctx*)
}

rule MEMPROCFS_AMSI_DEFENDER_TAMPER : memprocfs powershell amsi defender {
  meta:
    author = "Jumarf"
    description = "AMSI bypass and Defender tamper strings in scripts or loaders"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $amsi1 = "AmsiScanBuffer" ascii wide nocase
    $amsi2 = "amsi.dll" ascii wide nocase
    $amsi3 = "AmsiUtils" ascii wide nocase
    $def1 = "Set-MpPreference" ascii wide nocase
    $def2 = "Add-MpPreference" ascii wide nocase
    $def3 = "DisableRealtimeMonitoring" ascii wide nocase
    $def4 = "ExclusionPath" ascii wide nocase
    $def5 = "ExclusionProcess" ascii wide nocase
    $def6 = "MpCmdRun" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    2 of ($amsi*) and
    2 of ($def*)
}

rule MEMPROCFS_UAC_FILELESS_STAGER : memprocfs bypass uac stager {
  meta:
    author = "Jumarf"
    description = "Fileless UAC bypass and PowerShell staging strings"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $uac1 = "eventvwr" ascii wide nocase
    $uac2 = "fodhelper" ascii wide nocase
    $uac3 = "computerdefaults" ascii wide nocase
    $stg1 = "powershell -nop" ascii wide nocase
    $stg2 = "(new-object net.webclient).downloaddata" ascii wide nocase
    $stg3 = "(new-object net.webclient).downloadstring" ascii wide nocase
    $stg4 = "[reflection.assembly]::load($bytes)" ascii wide nocase
    $stg5 = "frombase64string" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    1 of ($uac*) and
    2 of ($stg*)
}

rule MEMPROCFS_TRACE_CLEANER_TAMPER : memprocfs cleaner traces {
  meta:
    author = "Jumarf"
    description = "Trace-cleaning strings that commonly appear in screenshare bypass and cleanup tooling"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $trace1 = "usnjrnl" ascii wide nocase
    $trace2 = "recentfilecache" ascii wide nocase
    $trace3 = "amcache" ascii wide nocase
    $trace4 = "muicache" ascii wide nocase
    $trace5 = "userassist" ascii wide nocase
    $trace6 = "shimcache" ascii wide nocase
    $trace7 = "prefetch" ascii wide nocase
    $trace8 = "bam\\state\\usersettings" ascii wide nocase
    $act1 = "self delete" ascii wide nocase
    $act2 = "delete traces" ascii wide nocase
    $act3 = "clear traces" ascii wide nocase
    $act4 = "trace cleaner" ascii wide nocase
    $act5 = "clean traces" ascii wide nocase
    $act6 = "selfdestruct" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    2 of ($trace*) and
    1 of ($act*)
}

rule MEMPROCFS_CLUMSY_UI_TEXT : memprocfs network_tool clumsy {
  meta:
    author = "Jumarf"
    description = "Clumsy UI and runtime strings suitable for in-memory detection"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $event1 = "Global\\CLUMSY_IS_RUNNING_EVENT_NAME" ascii wide
    $msg1 = "Theres' already an instance of clumsy running." ascii wide
    $msg2 = "You're running 32bit clumsy on 64bit Windows, which wouldn't work. Please use the 64bit clumsy version." ascii wide
    $msg3 = "Started filtering. Enable functionalities to take effect." ascii wide
    $msg4 = "Stopped. To begin again, edit criteria and click Start." ascii wide
    $ui1 = "loopback packets" ascii wide
    $ui2 = "NOTICE: When capturing localhost (loopback) packets, you CAN'T include inbound criteria." ascii wide
    $ui3 = "Filters like 'udp' need to be 'udp and outbound' to work. See readme for more info." ascii wide
    $ui4 = "clumsy " ascii wide

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      $event1 or
      (1 of ($msg*) and 1 of ($ui*)) or
      ($ui4 and 2 of ($msg*,$ui1,$ui2,$ui3))
    )
}

rule MEMPROCFS_NOPING_UI_TEXT : memprocfs network_tool noping {
  meta:
    author = "Jumarf"
    description = "NoPing UI and feature strings suitable for in-memory detection"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $brand1 = "NoPing" ascii wide
    $brand2 = "NoPing Game Booster" ascii wide
    $dom1 = "noping.com" ascii wide
    $dom2 = "nptunnel.com" ascii wide
    $ui1 = "Optimize this game" ascii wide
    $ui2 = "Optimize Game" ascii wide
    $ui3 = "Turbo Games" ascii wide
    $ui4 = "Smart Exit" ascii wide
    $ui5 = "Start NoPing with Windows" ascii wide
    $ui6 = "Windows Packet Filter" ascii wide
    $ui7 = "Game Statistics" ascii wide
    $ui8 = "DISCONNECT" ascii wide
    $ui9 = "Select the server" ascii wide
    $feat1 = "Multi Connection" ascii wide
    $feat2 = "Multi Internet" ascii wide
    $feat3 = "AI Route Calculation" ascii wide

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      (1 of ($brand*) and 2 of ($ui*)) or
      (1 of ($brand*,$dom1,$dom2) and 2 of ($feat*)) or
      ($brand1 and 1 of ($feat*) and 1 of ($ui*))
    )
}

rule MEMPROCFS_EXITLAG_UI_TEXT : memprocfs network_tool exitlag {
  meta:
    author = "Jumarf"
    description = "ExitLag UI and feature strings suitable for in-memory detection"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $brand1 = "ExitLag" ascii wide
    $dom1 = "exitlag.com" ascii wide
    $ui1 = "Apply Routes" ascii wide
    $ui2 = "CONNECTED" ascii wide
    $ui3 = "Choose a region or server" ascii wide
    $ui4 = "Automatic choice" ascii wide
    $ui5 = "ExitLag ON" ascii wide
    $feat1 = "Multipath Connection" ascii wide
    $feat2 = "Multi Internet" ascii wide
    $feat3 = "FPS Boost" ascii wide
    $feat4 = "Traffic Shaper" ascii wide
    $feat5 = "Network Analyzer" ascii wide
    $feat6 = "RAM Cleaner" ascii wide

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      ($brand1 and 2 of ($ui*)) or
      (1 of ($brand1,$dom1) and 2 of ($feat*)) or
      ($brand1 and $ui1 and 1 of ($feat*))
    )
}

rule MEMPROCFS_NETLIMITER_UI_TEXT : memprocfs network_tool netlimiter {
  meta:
    author = "Jumarf"
    description = "NetLimiter strings suitable for in-memory detection"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $brand = "NetLimiter" ascii wide
    $vendor = "Locktime Software" ascii wide
    $exe1 = "NLClientApp.exe" ascii wide
    $exe2 = "NLDiag.exe" ascii wide
    $svc1 = "nlsvc.exe" ascii wide
    $svc2 = "nlsvc" ascii wide fullword
    $drv1 = "nldrv" ascii wide fullword
    $api1 = "NetLimiter.Service.NLClient" ascii wide
    $api2 = "NetLimiter.Service.NLService" ascii wide
    $path1 = "C:\\Program Files\\Locktime Software\\NetLimiter\\NetLimiter.dll" ascii wide
    $path2 = "C:\\Program Files\\Locktime Software\\NetLimiter 4\\NetLimiter.dll" ascii wide

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      ($brand and 1 of ($exe*,$svc*,$drv*,$api*,$path*)) or
      ($vendor and 2 of ($exe*,$svc*,$drv*,$api*,$path*))
    )
}

rule MEMPROCFS_CHEAT_ENGINE_ARTIFACTS_TEXT : memprocfs cheat_engine {
  meta:
    author = "Jumarf"
    description = "Cheat Engine artifacts that are safe enough for memory hunting"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $ce_name = "Cheat Engine" ascii wide nocase
    $ce_exe = "Cheat Engine.exe" ascii wide nocase
    $ce_drv1 = "dbk64.sys" ascii wide nocase
    $ce_drv2 = "dbk32.sys" ascii wide nocase
    $ce_dll1 = "speedhack-i386.dll" ascii wide nocase
    $ce_dll2 = "speedhack-x86_64.dll" ascii wide nocase
    $ce_dll3 = "vehdebug-i386.dll" ascii wide nocase
    $ce_dll4 = "vehdebug-x86_64.dll" ascii wide nocase
    $ce_misc1 = "tutorial-i386.exe" ascii wide nocase
    $ce_misc2 = "tutorial-x86_64.exe" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      any of ($ce_drv*, $ce_dll*, $ce_misc*) or
      ($ce_name and 1 of ($ce_drv*, $ce_dll*, $ce_misc*)) or
      $ce_exe
    )
}

rule MEMPROCFS_KDMAPPER_ARTIFACTS_TEXT : memprocfs kdmapper driver_loader {
  meta:
    author = "Jumarf"
    description = "kdmapper and vulnerable-driver loader artifacts that remain stable in memory"
    target = "MemProcFS process or kernel virtual memory"

  strings:
    $map1 = "kdmapper" ascii wide nocase
    $map2 = "iqvw64e.sys" ascii wide nocase
    $map3 = "\\Device\\Nal" ascii wide nocase
    $map4 = "MmUnloadedDrivers" ascii wide nocase
    $map5 = "PiDDBCacheTable" ascii wide nocase
    $map6 = "g_KernelHashBucketList" ascii wide nocase
    $map7 = "Wdfilter RuntimeDriverList" ascii wide nocase
    $map8 = "capcom.sys" ascii wide nocase
    $map9 = "gdrv.sys" ascii wide nocase
    $map10 = "dbutil_2_3.sys" ascii wide nocase
    $map11 = "RTCore64.sys" ascii wide nocase
    $map12 = "WinRing0x64.sys" ascii wide nocase
    $map13 = "WinRing0.sys" ascii wide nocase
    $api1 = "NtLoadDriver" ascii wide nocase
    $api2 = "NtUnloadDriver" ascii wide nocase

  condition:
    not _MEMPROCFS_NOISE_CONTEXT and
    (
      2 of ($map*) or
      (1 of ($map*) and 1 of ($api*)) or
      ($map1 and 1 of ($map2,$map3,$map4,$map5,$map6,$map7))
    )
}

rule MPFS_STRICT_KnownCheatArtifacts_PE : cheat pe lowfp {
  meta:
    description = "Strict low-FP detection of known cheat loaders and clients in PE files"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $brand1 = "Exodus.codes" nocase ascii wide
    $brand2 = "slinky.gg" nocase ascii wide
    $brand3 = "vape.gg" nocase ascii wide
    $brand4 = "lithiumclient.wtf" nocase ascii wide
    $brand5 = "discord.gg/advantages" nocase ascii wide
    $dll1 = "slinkyhook.dll" nocase ascii wide
    $dll2 = "slinky_library.dll" nocase ascii wide
    $dll3 = "breeze.dll" nocase ascii wide
    $msg1 = "[!] Failed to find Vape jar" nocase ascii wide
    $msg2 = "Vape Launcher" nocase ascii wide
    $msg3 = "Open Minecraft, then try again." nocase ascii wide
    $msg4 = "Adding delay to Minecraft" nocase ascii wide
    $name1 = "Cracked by Kangaroo" nocase ascii wide
    $name2 = "Sapphire LITE Clicker" nocase ascii wide
    $name3 = "Monolith Lite" nocase ascii wide
    $name4 = "UNICORN CLIENT" nocase ascii wide
    $name5 = "UwU Client" nocase ascii wide
    $name6 = "dream-injector" nocase ascii wide
    $name7 = "VROOMCLICKER" nocase ascii wide
    $pdb1 = "C:\\Users\\PC\\Desktop\\Cleaner-main\\obj\\x64\\Release\\WindowsFormsApp3.pdb" nocase ascii wide
    $pdb2 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-external.pdb" nocase ascii wide
    $pdb3 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-internal.pdb" nocase ascii wide
    $pdb4 = "C:\\Users\\DeathZ\\source\\repos\\StarDLL\\x64\\Release\\MoonDLL.pdb" nocase ascii wide
    $pdb5 = "C:\\Users\\mella\\source\\repos\\Fox v2\\x64\\Release\\Fox.pdb" nocase ascii wide
    $pdb6 = "C:\\Users\\hyeox\\Desktop\\imgui-master\\examples\\example_win32_directx9\\Release\\icetea_dx9_final.pdb" nocase ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      any of ($pdb*) or
      2 of ($dll*, $msg*, $name*) or
      2 of ($brand*)
    )
}

rule MPFS_STRICT_NativeClicker_PE : cheat pe lowfp {
  meta:
    description = "Strict native clicker detection via combined synthetic-input imports"
    author = "Jumarf"
    date = "2026-04-21"

  condition:
    pe.is_pe and
    not dotnet.is_dotnet and
    filesize <= 67108864 and
    pe.number_of_imported_functions <= 140 and
    (
      pe.imports("user32.dll", "SendInput") or
      pe.imports("user32.dll", "mouse_event")
    ) and
    (
      pe.imports("user32.dll", "GetAsyncKeyState") or
      pe.imports("user32.dll", "GetKeyState")
    ) and
    (
      pe.imports("user32.dll", "SetCursorPos") or
      pe.imports("user32.dll", "mouse_event") or
      pe.imports("user32.dll", "SendInput")
    )
}

rule MPFS_STRICT_DotNetClicker_PE : cheat pe dotnet lowfp {
  meta:
    description = "Strict .NET clicker detection via API plus UI keyword combinations"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $inj1 = "SendInput" ascii wide
    $inj2 = "mouse_event" ascii wide
    $inj3 = "SetCursorPos" ascii wide
    $key1 = "GetAsyncKeyState" ascii wide
    $key2 = "GetKeyState" ascii wide
    $kw1 = "AutoClicker" nocase ascii wide
    $kw2 = "Click Interval" nocase ascii wide
    $kw3 = "Start Clicking" nocase ascii wide
    $kw4 = "Stop Clicking" nocase ascii wide
    $kw5 = "Jitter Click" nocase ascii wide
    $kw6 = "Butterfly Click" nocase ascii wide
    $kw7 = "Double Clicker" nocase ascii wide
    $kw8 = "String Cleaner" nocase ascii wide

  condition:
    pe.is_pe and
    dotnet.is_dotnet and
    filesize <= 67108864 and
    1 of ($inj*) and
    1 of ($key*) and
    1 of ($kw*)
}

rule MPFS_STRICT_Injector_ManualMap_PE : injector hacktool pe lowfp {
  meta:
    description = "Strict PE-only detection of injectors and manual-map loaders"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $msg1 = "Injecting DLL: %ls into PID: %d" ascii wide
    $msg2 = "Cannot write the shellcode in the process memory, error:" ascii wide
    $msg3 = "/d dll_file PID: dll injection via LoadLibrary()." ascii wide
    $msg4 = "Error injecting remote thread in process:" ascii wide
    $msg5 = "No injection target has been provided!" ascii wide
    $msg6 = "BBInjectDll" ascii wide
    $msg7 = "BlackBone: %s: APC injection failed with status 0x%X" ascii wide
    $msg8 = "%s: Invalid injection type specified - %d" ascii wide
    $msg9 = "Specify -l to list all IE processes running in the current session" ascii wide
    $api1 = "CreateRemoteThread" ascii wide
    $api2 = "NtCreateThreadEx" ascii wide
    $api3 = "WriteProcessMemory" ascii wide
    $api4 = "VirtualAllocEx" ascii wide
    $api5 = "LoadLibraryA" ascii wide
    $api6 = "LoadLibraryW" ascii wide
    $api7 = "LdrLoadDll" ascii wide
    $trait1 = "ManualMap" ascii wide
    $trait2 = "ReflectiveLoader" ascii wide
    $trait3 = "InjectDLL" ascii wide
    $trait4 = "shellcode injection" ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      2 of ($msg*) or
      ($msg6 and $api7 and 1 of ($msg7,$msg8)) or
      (4 of ($api*) and 1 of ($trait*))
    )
}

rule MPFS_STRICT_CheatEngine_PE : cheat pe lowfp {
  meta:
    description = "Strict PE-only Cheat Engine detection to avoid cache and text false positives"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $ce_name = "Cheat Engine" nocase ascii wide
    $ce_exe = "Cheat Engine.exe" nocase ascii wide
    $ce_drv1 = "dbk64.sys" nocase ascii wide
    $ce_drv2 = "dbk32.sys" nocase ascii wide
    $ce_dll1 = "speedhack-i386.dll" nocase ascii wide
    $ce_dll2 = "speedhack-x86_64.dll" nocase ascii wide
    $ce_dll3 = "vehdebug-i386.dll" nocase ascii wide
    $ce_dll4 = "vehdebug-x86_64.dll" nocase ascii wide
    $ce_misc1 = "tutorial-i386.exe" nocase ascii wide
    $ce_misc2 = "tutorial-x86_64.exe" nocase ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      any of ($ce_drv*, $ce_dll*, $ce_misc*) or
      ($ce_name and 1 of ($ce_drv*, $ce_dll*, $ce_misc*)) or
      $ce_exe
    )
}

rule MPFS_STRICT_KDMapper_VulnDriver_PE : cheat hacktool kernel pe lowfp {
  meta:
    description = "Strict PE-only detection of kdmapper and vulnerable-driver loader ecosystems"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $map1 = "kdmapper" nocase ascii wide
    $map2 = "iqvw64e.sys" nocase ascii wide
    $map3 = "\\Device\\Nal" nocase ascii wide
    $map4 = "MmUnloadedDrivers" nocase ascii wide
    $map5 = "PiDDBCacheTable" nocase ascii wide
    $map6 = "g_KernelHashBucketList" nocase ascii wide
    $map7 = "Wdfilter RuntimeDriverList" nocase ascii wide
    $map8 = "capcom.sys" nocase ascii wide
    $map9 = "gdrv.sys" nocase ascii wide
    $map10 = "dbutil_2_3.sys" nocase ascii wide
    $map11 = "RTCore64.sys" nocase ascii wide
    $map12 = "WinRing0x64.sys" nocase ascii wide
    $map13 = "WinRing0.sys" nocase ascii wide
    $map14 = "AsIO.sys" nocase ascii wide
    $map15 = "AsIO2.sys" nocase ascii wide
    $map16 = "AsUpIO.sys" nocase ascii wide
    $map17 = "eneio64.sys" nocase ascii wide
    $map18 = "MSIO64.sys" nocase ascii wide
    $map19 = "NTIOLib_X64.sys" nocase ascii wide
    $map20 = "nvoclock.sys" nocase ascii wide
    $api1 = "NtLoadDriver" ascii wide
    $api2 = "NtUnloadDriver" ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      2 of ($map*) or
      (1 of ($map*) and 1 of ($api*)) or
      ($map1 and 1 of ($map2,$map3,$map4,$map5,$map6,$map7))
    )
}

rule MPFS_STRICT_Clumsy_PE : network_tool prohibited_game_tool pe lowfp {
  meta:
    description = "Strict PE-only detection of Clumsy"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $event1 = "Global\\CLUMSY_IS_RUNNING_EVENT_NAME" ascii wide
    $msg1 = "Theres' already an instance of clumsy running." ascii wide
    $msg2 = "You're running 32bit clumsy on 64bit Windows, which wouldn't work. Please use the 64bit clumsy version." ascii wide
    $msg3 = "Started filtering. Enable functionalities to take effect." ascii wide
    $msg4 = "Stopped. To begin again, edit criteria and click Start." ascii wide
    $ui1 = "loopback packets" ascii wide
    $ui2 = "NOTICE: When capturing localhost (loopback) packets, you CAN'T include inbound criteria." ascii wide
    $ui3 = "Filters like 'udp' need to be 'udp and outbound' to work. See readme for more info." ascii wide
    $ui4 = "clumsy " ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      $event1 or
      (1 of ($msg*) and 1 of ($ui*)) or
      ($ui4 and 2 of ($msg*,$ui1,$ui2,$ui3))
    )
}

rule MPFS_STRICT_NetLimiter_PE : network_tool prohibited_game_tool pe lowfp {
  meta:
    description = "Strict PE-only detection of NetLimiter"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $brand = "NetLimiter" ascii wide
    $vendor = "Locktime Software" ascii wide
    $exe1 = "NLClientApp.exe" ascii wide
    $exe2 = "NLDiag.exe" ascii wide
    $svc1 = "nlsvc.exe" ascii wide
    $svc2 = "nlsvc" ascii wide fullword
    $drv1 = "nldrv" ascii wide fullword
    $api1 = "NetLimiter.Service.NLClient" ascii wide
    $api2 = "NetLimiter.Service.NLService" ascii wide
    $path1 = "C:\\Program Files\\Locktime Software\\NetLimiter\\NetLimiter.dll" ascii wide
    $path2 = "C:\\Program Files\\Locktime Software\\NetLimiter 4\\NetLimiter.dll" ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      ($brand and 1 of ($exe*,$svc*,$drv*,$api*,$path*)) or
      ($vendor and 2 of ($exe*,$svc*,$drv*,$api*,$path*))
    )
}

rule MPFS_STRICT_NoPing_PE : network_tool prohibited_game_tool pe lowfp {
  meta:
    description = "Strict PE-only detection of NoPing"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $brand1 = "NoPing" ascii wide
    $brand2 = "NoPing Game Booster" ascii wide
    $dom1 = "noping.com" ascii wide
    $dom2 = "nptunnel.com" ascii wide
    $ui1 = "Optimize this game" ascii wide
    $ui2 = "Optimize Game" ascii wide
    $ui3 = "Turbo Games" ascii wide
    $ui4 = "Smart Exit" ascii wide
    $ui5 = "Start NoPing with Windows" ascii wide
    $ui6 = "Windows Packet Filter" ascii wide
    $ui7 = "Game Statistics" ascii wide
    $ui8 = "DISCONNECT" ascii wide
    $ui9 = "Select the server" ascii wide
    $feat1 = "Multi Connection" ascii wide
    $feat2 = "Multi Internet" ascii wide
    $feat3 = "AI Route Calculation" ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      (1 of ($brand*) and 2 of ($ui*)) or
      (1 of ($brand*,$dom1,$dom2) and 2 of ($feat*)) or
      ($brand1 and 1 of ($feat*) and 1 of ($ui*))
    )
}

rule MPFS_STRICT_ExitLag_PE : network_tool prohibited_game_tool pe lowfp {
  meta:
    description = "Strict PE-only detection of ExitLag"
    author = "Jumarf"
    date = "2026-04-21"

  strings:
    $brand1 = "ExitLag" ascii wide
    $dom1 = "exitlag.com" ascii wide
    $ui1 = "Apply Routes" ascii wide
    $ui2 = "CONNECTED" ascii wide
    $ui3 = "Choose a region or server" ascii wide
    $ui4 = "Automatic choice" ascii wide
    $ui5 = "ExitLag ON" ascii wide
    $feat1 = "Multipath Connection" ascii wide
    $feat2 = "Multi Internet" ascii wide
    $feat3 = "FPS Boost" ascii wide
    $feat4 = "Traffic Shaper" ascii wide
    $feat5 = "Network Analyzer" ascii wide
    $feat6 = "RAM Cleaner" ascii wide

  condition:
    _mpfs_valid_pe_header and
    (
      ($brand1 and 2 of ($ui*)) or
      (1 of ($brand1,$dom1) and 2 of ($feat*)) or
      ($brand1 and $ui1 and 1 of ($feat*))
    )
}
