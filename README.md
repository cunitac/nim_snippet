# nim_snippet
NimのVSCode用スニペット管理ツール

# 使い方
スニペットを書いた`.nim`ファイルの入っているディレクトリ`snip`に対して
```bash
$ nim_snippet snip
```
とすると，VSCode用のスニペットが標準出力に書きだされる．

# スニペットの書き方
`#snip: name`と書くと，次の`#snip:`またはEOFまでが`name`という名前のスニペットに追加される．

```nim
#snip: snippet1
proc addOne(n: int): int = n + 1
proc addTwo(n: int): int = n + 2
```

`#snip: name1 name2`と書くと，`name1`および`name2`という名前のスニペットに追加される．

# 注意
コード成形は一切行われない．`#snip: name`から次の`#snip:`の直前までがそのままスニペットとして扱われる．