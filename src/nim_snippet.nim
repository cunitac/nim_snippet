import system
import os
import strutils
import json
import sequtils

const snipPrefix = "#snip:"

proc addForEachNames(snip: var JsonNode; names, body: seq[string]) =
  let jaBody = body.map(`%`)
  for name in names:
    if name notin snip:
      snip[name] = newJObject()
      snip[name]["prefix"] = % name
      snip[name]["scope"] = % "nim"
      snip[name]["body"] = newJArray()
    snip[name]["body"].elems.add jaBody

proc addFile(snip: var JsonNode; filename: string) =
  var names, body = newSeq[string]()
  for line in filename.lines:
    if line.startsWith snipPrefix:
      snip.addForEachNames(names, body)
      names = line[snipPrefix.len..^1].strip.split
      body = newSeq[string]()
    else:
      body &= line
  snip.addForEachNames(names, body)
      
when isMainModule:
  if paramCount() == 0:
    quit QuitFailure
  
  var snippet = newJObject()
  
  setCurrentDir commandLineParams()[0]
  for filename in walkFiles("*.nim"):
    snippet.addFile filename
  
  echo snippet.pretty