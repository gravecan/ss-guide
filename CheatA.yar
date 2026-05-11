import "pe"
import "math"
import "dotnet"
import "hash"

rule sA_any
{
    strings:
        /* “домены/идентификаторы” */
        $dom1 = "Exodus.codes" nocase ascii wide
        $dom2 = "slinky.gg" nocase ascii wide
        $dom3 = "vape.gg" nocase ascii wide
        $dom4 = "lithiumclient.wtf" nocase ascii wide
        $dom5 = "breeze.rip" nocase ascii wide
        $dom6 = "discord.gg/advantages" nocase ascii wide

        /* “файлы/модули” */
        $dll1 = "slinkyhook.dll" nocase ascii wide
        $dll2 = "slinky_library.dll" nocase ascii wide
        $dll3 = "breeze.dll" nocase ascii wide

        /* “сообщения/строки UI” */
        $msg1 = "[!] Failed to find Vape jar" nocase ascii wide
        $msg2 = "Vape Launcher" nocase ascii wide
        $msg3 = "Open Minecraft, then try again." nocase ascii wide
        $msg4 = "Failed injecting dll" nocase ascii wide
        $msg5 = "Adding delay to Minecraft" nocase ascii wide

        /* “имена/артефакты” */
        $name1 = "Sapphire LITE Clicker" nocase ascii wide
        $name2 = "Striker.exe" nocase ascii wide
        $name3 = "Cracked by Kangaroo" nocase ascii wide
        $name4 = "Monolith Lite" nocase ascii wide
        $name5 = "UNICORN CLIENT" nocase ascii wide
        $name6 = "UwU Client" nocase ascii wide

        /* PDB пути (очень специфично) */
        $pdb1 = "C:\\Users\\PC\\Desktop\\Cleaner-main\\obj\\x64\\Release\\WindowsFormsApp3.pdb" nocase ascii wide
        $pdb2 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-external.pdb" nocase ascii wide
        $pdb3 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-internal.pdb" nocase ascii wide

    condition:
        pe.is_pe and
        filesize <= 41943040 and
        any of them
}

rule CheatA
{
    strings:
        $ch_01 = "penis.dll" nocase ascii wide
        $ch_02 = "[!] Github: https://github.com/JohnXina-spec" nocase ascii wide
        $ch_03 = ".vapeclientT" nocase ascii wide
        $ch_04 = "(JLcn/gov/vape/util/jvmti/ClassLoadHook;)I" nocase ascii wide
        $ch_05 = "net/ccbluex/liquidbounce/UT" nocase ascii wide
        $ch_06 = "nick/AugustusClassLoader.class" nocase ascii wide
        $ch_07 = "com/riseclient/Main.class" nocase ascii wide
        $ch_08 = "slinky_library.dll" nocase ascii wide
        $ch_09 = "assets/minecraft/haru/img/clickgui/PK" nocase ascii wide
        $ch_10 = "assets/minecraft/sakura/sound/welcome.mp3" nocase ascii wide
        $ch_11 = "VROOMCLICKER" nocase ascii wide
        $ch_12 = "C:\\Users\\hyeox\\Desktop\\imgui-master\\examples\\example_win32_directx9\\Release\\icetea_dx9_final.pdb" nocase ascii wide
        $ch_13 = "Set autoclicker toggle key (It's can be a mouse button) -> " nocase ascii wide
        $ch_14 = "www.koid.es" nocase ascii wide
        $ch_15 = "vape.gg" nocase ascii wide
        $ch_16 = "C:\\Users\\DeathZ\\source\\repos\\StarDLL\\x64\\Release\\MoonDLL.pdb" nocase ascii wide
        $ch_17 = "DopeClicker" nocase ascii wide
        $ch_18 = "C:\\Users\\mella\\source\\repos\\Fox v2\\x64\\Release\\Fox.pdb" nocase ascii wide
        $ch_19 = "Cracked by Kangaroo" nocase ascii wide
        $ch_20 = "Sapphire LITE Clicker" nocase ascii wide
        $ch_21 = "dream-injector" nocase ascii wide
        $ch_22 = "Exodus.codes" nocase ascii wide
        $ch_23 = "slinky.gg" nocase ascii wide
        $ch_24 = "[!] Failed to find Vape jar" nocase ascii wide
        $ch_25 = "Vape Launcher" nocase ascii wide
        $ch_26 = "C:\\Users\\PC\\Desktop\\Cleaner-main\\obj\\x64\\Release\\WindowsFormsApp3.pdb" nocase ascii wide
        $ch_27 = "String Cleaner" nocase ascii wide
        $ch_28 = "Open Minecraft, then try again." nocase ascii wide
        $ch_29 = "PE Injector" nocase ascii wide
        $ch_30 = "starlight v1.0" nocase ascii wide
        $ch_31 = "Striker.exe" nocase ascii wide
        $ch_32 = "Monolith Lite" nocase ascii wide
        $ch_33 = "B.fagg0t0" nocase ascii wide
        $ch_34 = "B.fag0" nocase ascii wide
        $ch_35 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-external.pdb" nocase ascii wide
        $ch_36 = "C:\\Users\\Daniel\\Desktop\\client-top\\x64\\Release\\top-internal.pdb" nocase ascii wide
        $ch_37 = "UNICORN CLIENT" nocase ascii wide
        $ch_38 = "Adding delay to Minecraft" nocase ascii wide
        $ch_39 = "rightClickChk.BackgroundImage" nocase ascii wide
        $ch_40 = "UwU Client" nocase ascii wide
        $ch_41 = "lithiumclient.wtf" nocase ascii wide
        $ch_42 = "vape.g" nocase ascii wide
    condition:
        any of ($ch_*)
}

rule vapev4
{
    strings:
        $vape_01 = {41 6C 6C 6F 77 73 20 74 68 65 20 61 75 74 6F 63 6C 69 63 6B 65 72 20 74 6F 20 77 6F 72 6B 20 77 69 74 68 69 6E 20 74 68 65 20 69 6E 76 65 6E 74 6F 72 79}
    condition:
        $vape_01
}

rule vape_
{
    strings:
        $vape_02 = {45 6E 61 62 6C 65 73 20 74 68 65 20 75 73 65 20 6F 66 20 61 20 64 69 66 66 65 72 65 6E 74 20 61 75 74 6F 63 6C 69 63 6B 65 72 20 72 61 6E 64 6F 6D 69 7A 61 74 69 6F 6E}
    condition:
        $vape_02
}

rule vape_v4_client
{
    strings:
        $vape_03 = {76 61 70 65 63 6C 69 65 6E 74}
    condition:
        $vape_03
}

rule vape_v4_pdbpath
{
    strings:
        $vape_04 = {43 3A 5C 55 73 65 72 73 5C 69 73 74 65 6E 5C 44 65 73 6B 74 6F 70 5C 41 64 69 64 61 73 2D 4B 61 74 74 69 6E 74 6F 5C 78 36 34 5C 44 65 62 75 67 5C 41 64 69 64 61 73 43 6C 69 63 6B 65 72 2E 70 64 62}
    condition:
        $vape_04
}

rule vape_v4_jitterfactor
{
    strings:
        $vape_05 = {48 6F 77 20 6D 61 6E 79 20 6A 69 74 74 65 72 20 65 76 65 6E 74 73 20 73 68 6F 75 6C 64 20 49 20 63 61 6C 6C 20 70 65 72 20 74 69 63 6B 20 20 20 53 6D 6F 6F 74 68 6E 65 73 73 20 46 61 63 74 6F 72}
    condition:
        $vape_05
}

rule SkriptGG
{
    strings:
        $skript_1 = {21 54 68 69 73 20 70 72 6F 67 72 61 6D 20 63 61 6E 6E 6F 74 20 62 65 20 72 75 6E 20 69 6E 20 44 4F 53 20 6D 6F 64 65}
        $skript_2 = {73 6B 72 69 70 74 2E 64 6C 6C}
    condition:
        all of ($skript_*)
}

rule opautoclicker
{
    strings:
        $op_1 = {4F 20 50 20 20 20 41 20 75 20 74 20 6F 20 20 20 43 20 6C 20 69 20 63 20 6B 20 65 20 72}
    condition:
        $op_1
}

rule CrimDLL
{
    strings:
        $crim_1 = "sugma-cheat.pdb" nocase ascii wide
    condition:
        $crim_1
}

rule Crim5
{
    strings:
        $crim_2 = "Crim v1.01" nocase ascii wide
    condition:
        $crim_2
}

rule crimanother
{
    strings:
        $crim_3 = {73 75 67 6D 61 2D 6C 61 75 6E 63 68 65 72}
    condition:
        $crim_3
}

rule HackedClient
{
    strings:
        $hack_1 = "AutoClicker.class" nocase ascii wide
    condition:
        $hack_1
}

rule tzx_mogler
{
    strings:
        $tzx_1 = {44 3A 5C 50 72 6F 6A 65 74 73 5C 54 5A 58 5C 78 36 34 5C 52 65 6C 65 61 73 65 5C 4D 6F 64 75 6C 65 2E 70 64 62}
    condition:
        $tzx_1
}

rule GenericA
{
    strings:
        $gen_01 = "MinCPS" nocase ascii wide
        $gen_02 = "MaxCPS" nocase ascii wide
        $gen_03 = "In Inventory" nocase ascii wide
        $gen_04 = "Left mouse clicker" nocase ascii wide
        $gen_05 = "Right mouse clicker" nocase ascii wide
        $gen_06 = "Work in inventory" nocase ascii wide
        $gen_07 = "Spike chance" nocase ascii wide
        $gen_08 = "Drop Chance" nocase ascii wide
        $gen_09 = "Click to bind" nocase ascii wide
        $gen_10 = "b1scoito" nocase ascii wide
        $gen_11 = "kattinto" nocase ascii wide
        $gen_12 = "Double Clicker" nocase ascii wide
        $gen_13 = "Hide from OBS" nocase ascii wide
        $gen_14 = "Blockhit" nocase ascii wide
        $gen_15 = "Jitter force" nocase ascii wide
        $gen_16 = "Throwpot" nocase ascii wide
        $gen_17 = "Blockhit chance" nocase ascii wide
        $gen_18 = "Average CPS" nocase ascii wide
        $gen_19 = "Autoclicker Delay" nocase ascii wide
        $gen_20 = "ppclicker" nocase ascii wide
        $gen_21 = "Destructed Succesfully" nocase ascii wide
    condition:
        any of ($gen_*)
}

rule StringlessCleaner
{
    strings:
        $slc_1 = {73 74 72 69 6E 67 6C 65 73 73 4C 6F 67 6F 53 63 61 6E 6E 69 6E 67 5F 4D 6F 75 73 65 4D 6F 76 65}
        $slc_2 = {20 00 5B 00 20 00 43 00 4C 00 4F 00 53 00 49 00 4E 00 47 00 20 00 20 00 53 00 74 00 72 00 69 00 6E 00 67 00 6C 00 65 00 73 00 73 00 20 00 69 00 6E 00 20 00 38 00 20 00 73 00 65 00 63 00 6F 00 6E 00 64 00 73 00 20 00 20 00 20 00 5D 00}
        $slc_3 = {23 53 74 72 69 6E 67 6C 65 73 73 2E 46 6F 72 6D 31 2B 3C 67 65 74 54 61 67 41 73 79 6E 63 3E 64 5F 5F 31 39}
    condition:
        all of ($slc_*)
}

rule PeInjector_2
{
    strings:
        $inj2_1 = {21 54 68 69 73 20 70 72 6F 67 72 61 6D 20 63 61 6E 6E 6F 74 20 62 65 20 72 75 6E 20 69 6E 20 44 4F 53 20 6D 6F 64 65}
        $inj2_2 = {7E 20 69 6E 6A 65 63 74 6F 72}
        $inj2_3 = {41 72 67 73 3A 20 3C 73 68 65 6C 6C 63 6F 64 65 5F 66 69 6C 65 3E 20 3C 74 61 72 67 65 74 5F 50 49 44 3E}
        $inj2_4 = {49 6E 6A 65 63 74 69 6E 67 20 74 6F 3A 20 00 00 5B 45 52 52 4F 52 5D 20 43 6F 75 6C 64 20 6E 6F 74 20 6F 70 65 6E 20 70 72 6F 63 65 73 73}
        $inj2_5 = {49 6E 6A 65 63 74 65 64 2C 20 63 72 65 61 74 65 64 20 54 68 72 65 61 64 2C 20 69 64 20 3D 20}
        $inj2_6 = {43 6F 70 79 72 69 67 68 74 20 28 63 29 20 62 79 20 50 2E 4A 2E 20 50 6C 61 75 67 65 72 2C 20 6C 69 63 65 6E 73 65 64 20 62 79 20 44 69 6E 6B 75 6D 77 61 72 65 2C 20 4C 74 64 2E 20 41 4C 4C 20 52 49 47 48 54 53 20 52 45 53 45 52 56 45 44}
    condition:
        all of ($inj2_*)
}

rule CrackedDream
{
    strings:
        $cd_1 = {43 3A 5C 55 73 65 72 73 5C 47 65 62 72 75 69 6B 65 72 2E 45 47 4F 4E 5C 73 6F 75 72 63 65 5C 72 65 70 6F 73 5C 49 6E 6A 65 63 74 6F 72 5C 78 36 34 5C 52 65 6C 65 61 73 65 5C 49 6E 6A 65 63 74 6F 72 2E 70 64 62}
    condition:
        $cd_1
}

rule Clumsy
{
    strings:
        $clumsy_1 = {44 3A 5C 44 65 76 5C 4E 65 77 44 65 76 5C 63 6C 75 6D 73 79 5C 63 6C 75 6D 73 79 2D 6D 61 73 74 65 72 5C 62 75 69 6C 64}
        $clumsy_2 = {63 3A 5C 63 72 6F 73 73 64 65 76 5C 67 63 63 6D 61 73 74 65 72 5C 62 75 69 6C 64 2D 74 64 6D 36 34 5C 67 63 63 5C 78 38 36 5F 36 34 2D 77 36 34 2D 6D 69 6E 67 77 33 32 5C 6C 69 62 67 63 63}
    condition:
        all of ($clumsy_*)
}

rule MoonDLL
{
    strings:
        $moon_1 = {43 3A 5C 55 73 65 72 73 5C 44 65 61 74 68 5A 5C 73 6F 75 72 63 65 5C 72 65 70 6F 73 5C 53 74 61 72 44 4C 4C 5C 78 36 34 5C 52 65 6C 65 61 73 65 5C 4D 6F 6F 6E 44 4C 4C 2E 70 64 62}
        $moon_2 = {63 64 20 22 43 3A 5C 57 69 6E 64 6F 77 73 22 2D 63 64 20 22 43 3A 5C 57 69 6E 64 6F 77 73 22 4A 63 64 20 22 43 3A 5C 57 69 6E 64 6F 77 73 22 4F 63 64 20 22 43 3A 5C 57 69 6E 64 6F 77 73 22 57 63 64 20 22 43 3A 5C 57 69 6E 64 6F 77 73 22 62 63 64 20}
    condition:
        all of ($moon_*)
}

rule PeInjector_1
{
    strings:
        $inj1_1 = {21 54 68 69 73 20 70 72 6F 67 72 61 6D 20 63 61 6E 6E 6F 74 20 62 65 20 72 75 6E 20 69 6E 20 44 4F 53 20 6D 6F 64 65}
        $inj1_2 = {43 3A 5C 55 73 65 72 73 5C 55 73 65 72 5C 73 6F 75 72 63 65 5C 72 65 70 6F 73 5C 69 6E 74 61 6C 6C 5C 78 36 34 5C 52 65 6C 65 61 73 65 5C 69 6E 74 61 6C 6C 2E 70 64 62}
        $inj1_3 = "calc.exe" ascii wide
    condition:
        all of ($inj1_*)
}

rule ExodusAim
{
    strings:
        $ex_1 = {43 3A 5C 55 73 65 72 73 5C 44 61 6E 69 65 6C 5C 44 65 73 6B 74 6F 70 5C 63 6C 69 65 6E 74 2D 74 6F 70 5C 78 36 34 5C 52 65 6C 65 61 73 65 5C 74 6F 70 2D 65 78 74 65 72 6E 61 6C 2E 70 64 62}
    condition:
        $ex_1
}

rule ProcessHollower_3
{
    strings:
        $ph3_1 = {44 3A 5C 4F 6E 65 44 72 69 76 65 5C 43 6F 64 65 5C 4B 69 6E 67 48 61 6D 6C 65 74 5C 78 36 34 5C 52 65 6C 65 61 73 65 5C 4B 69 6E 67 48 61 6D 6C 65 74 2E 70 64 62}
    condition:
        $ph3_1
}

rule ProcessHollower_2
{
    strings:
        $ph2_1 = {50 72 6F 63 65 73 73 20 47 68 6F 73 74 69 6E 67}
        $ph2_2 = {5B 21 5D 20 54 68 65 20 70 61 79 6C 6F 61 64 20 68 61 73 20 6D 69 73 6D 61 74 63 68 69 6E 67 20 62 69 74 6E 65 73 73 21}
    condition:
        all of ($ph2_*)
}

rule AutoClicker
{
    strings:
        $ac_1 = "AutoClicker" nocase ascii wide
        $ac_2 = "Click Interval" nocase ascii wide
        $ac_3 = "Start Clicking" nocase ascii wide
        $ac_4 = "Stop Clicking" nocase ascii wide
        $ac_5 = "mouse_event" nocase ascii wide
    condition:
        3 of ($ac_*)
}