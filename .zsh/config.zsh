#################################  HISTORY  #################################
# history
HISTFILE=$HOME/.zsh-history # 履歴を保存するファイル
HISTSIZE=100000             # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000            # 上述のファイルに保存する履歴のサイズ

# share .zshhistory
setopt inc_append_history   # 実行時に履歴をファイルにに追加していく
setopt share_history        # 履歴を他のシェルとリアルタイム共有する
setopt hist_ignore_dups     # 前と重複する行は記録しない
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt hist_ignore_space    # 行頭がスペースのコマンドは記録しない
setopt hist_ignore_all_dups # 履歴中の重複行をファイル記録前に無くす
setopt hist_find_no_dups    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt hist_no_store        # histroyコマンドは記録しない

# 条件を満たすコマンドのみを histoty に追加
# http://mollifier.hatenablog.com/entry/20090728/p1
zshaddhistory() {
    local line=${1%%$'\n'} 
    local cmd=${line%% *} 
    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (cd)
        && ${cmd} != (m|man)
        && ${cmd} != (r[mr])
    ]]
}

#################################  COMPLEMENT  #################################
# enable completion
autoload -Uz compinit && compinit

# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''


### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

#################################  OTHERS  #################################
# automatically change directory when dir name is typed
setopt auto_cd

# disable ctrl+s, ctrl+q
setopt no_flow_control

# ビープ音の停止
setopt no_beep

# ビープ音の停止(補完時)
setopt nolistbeep

#何も入力されていないときのTABでTABが挿入されるのを抑制
zstyle ':completion:*' insert-tab false

# コマンドの打ち間違いを指摘
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "
