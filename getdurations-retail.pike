#!/usr/bin/env pike

int main(int argc, array argv) {
  string spells = Stdio.read_file("MagicComm/CCSpellIDs.lua");
  array(int) spellids = ({});
  int spellid;
  constant url = "curl -L -q https://www.wowhead.com/spell=%d 2>/dev/null";
  sscanf(spells, "%*s]]%s-- Spell durations in seconds", spells);
  write("comm.spellIdToDuration = {\n");
  mapping output = ([]);

  while(sscanf(spells, "%*s[%d]%s", spellid, spells) > 1) {
    //  spellids += ({spellid});
    //    write("Found spell ID %d\n", spellid);
    werror("Getting data for spell id %d...\n", spellid);
    string spelldata = Process.popen(sprintf(url, spellid));
    if(!spelldata) {
      werror("  UNKNOWN SPELL %d\n", spellid);
      continue;
    }
    int duration;
//        werror("%O\n", array_sscanf(spelldata, "%sDuration<%s><%s>%d second"));
  //      exit(1);
    string scale;

    if(sscanf(spelldata, "%*s<th>Duration</th>%*s<%*s>%d %s<", duration, scale) == 5) {
      if(scale[..2] == "min") {
	duration = duration * 60;
      }
      output[spellid] = duration;
    } else {
      if(spellid == 5782) { 
        output[spellid] = 20; // hard coded since duratioon isn't obvious
      } else {
        werror("  Didn't find duration...\n");
      }
    }
    
  }
  foreach(sort(indices(output)), int spellid) {
    write("   [%d] = %d, \n", spellid, output[spellid]);
  }
  write("}\n");
}
