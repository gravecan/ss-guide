import "pe"
import "math"
import "dotnet"
import "hash"

rule F_tight2_unsigned
{
    meta:
        description = "High-entropy PE heuristic"
        author = "jumarf"
        date = "2026-01-28"

    condition:
        pe.is_pe and
        filesize <= 41943040 and
        pe.number_of_signatures == 0 and

        (
            (pe.section_index(pe.entry_point) >= 0 and
             (pe.sections[pe.section_index(pe.entry_point)].characteristics & pe.SECTION_MEM_EXECUTE) != 0 and
             pe.sections[pe.section_index(pe.entry_point)].raw_data_size > 20480 and
             math.entropy(
                pe.sections[pe.section_index(pe.entry_point)].raw_data_offset,
                pe.sections[pe.section_index(pe.entry_point)].raw_data_size
             ) >= 7.25)
            or
            (for any i in (0..pe.number_of_sections-1) : (
                (pe.sections[i].characteristics & pe.SECTION_MEM_EXECUTE) != 0 and
                pe.sections[i].raw_data_size > 32768 and
                not (pe.sections[i].name == ".rsrc" or pe.sections[i].name == ".reloc" or pe.sections[i].name == ".pdata") and
                math.entropy(pe.sections[i].raw_data_offset, pe.sections[i].raw_data_size) >= 7.65
            ))
        )
        and
        (
            (math.entropy(0, filesize) >= 7.62 and pe.number_of_imports <= 10)
            or
            (dotnet.is_dotnet and
             for any j in (0..dotnet.number_of_streams-1) : (
                (dotnet.streams[j].name == "#EncryptedStrings" or dotnet.streams[j].name == "#StrEnc") and
                dotnet.streams[j].size >= 64 and dotnet.streams[j].size <= 16384 and
                math.entropy(dotnet.streams[j].offset, dotnet.streams[j].size) >= 7.20
             ))
        )
}