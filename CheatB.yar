import "pe"
import "math"
import "dotnet"
import "hash"

rule A_keywords_tight
{
    strings:
        $kw1 = /\bauto\s*click(er)?\b/i ascii wide
        $kw2 = /\bautoclick\b/i ascii wide
        $kw3 = /\bclick\s*interval\b/i ascii wide
        $kw4 = /\bjitter\s*click\b/i ascii wide
        $kw5 = /\bbutterfly\s*click\b/i ascii wide
        $kw6 = /\bdouble[-_\s]*clicker\b/i ascii wide
        $kw7 = /\bstring\s*cleaner\b/i ascii wide

    condition:
        pe.is_pe and
        filesize <= 41943040 and
        1 of ($kw*)
}

rule A2_inputs_tight
{
    condition:
        pe.is_pe and
        not dotnet.is_dotnet and
        filesize <= 41943040 and

        /* режем огромные фреймворк-DLL/плагины, которые всё подряд импортят */
        pe.number_of_imported_functions <= 140 and

        /* синтетический ввод (хотя бы одно) */
        (
            pe.imports("user32.dll", "SendInput") or
            pe.imports("user32.dll", "mouse_event")
        ) and

        /* чтение состояния клавиш (хотя бы одно) */
        (
            pe.imports("user32.dll", "GetAsyncKeyState") or
            pe.imports("user32.dll", "GetKeyState")
        ) and

        /* часто идёт вместе в таких тулзах */
        (
            pe.imports("user32.dll", "SetCursorPos") or
            pe.imports("user32.dll", "mouse_event") or
            pe.imports("user32.dll", "SendInput")
        ) and

        /* опционально: не трогать подписанных конкретными авторами */
        not (
            pe.number_of_signatures > 0 and
            for any s in (0..pe.number_of_signatures-1) : (
                pe.signatures[s].subject matches /Eric\s+R\.\s+Zimmerman/i or
                pe.signatures[s].subject matches /Gaston\s+Dallavalle/i
            )
        )
}

rule A3_dotnet_tight
{
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
        filesize <= 41943040 and
        (1 of ($inj*)) and
        (1 of ($key*)) and
        (1 of ($kw*)) and

        not (
            pe.number_of_signatures > 0 and
            for any s in (0..pe.number_of_signatures-1) : (
                pe.signatures[s].subject matches /Eric\s+R\.\s+Zimmerman/i or
                pe.signatures[s].subject matches /Gaston\s+Dallavalle/i
            )
        )
}