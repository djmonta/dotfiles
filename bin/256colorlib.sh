# 256colorlib.sh - 256色拡張の色指定を定義
# (C) 2008 kakurasan
# gen-256colorlib.shより生成

# 対応シェル : bash, zsh
# 使用例     : . 256colorlib.sh もしくは source 256colorlib.sh

# 定義される変数
#  COLOR_FG_rrggbb : 前景色を#rrggbbに変更
#  COLOR_BG_rrggbb : 背景色を#rrggbbに変更
#  STYLE_DEFAULT   : 色とスタイルをリセット
#  STYLE_BOLD      : 太字
#  STYLE_LINE      : 下線
#  STYLE_NEGA      : 前景色と背景色を入れ替える
#  STYLE_NOLINE    : 下線なし

# シェル判別
if test -n "${BASH_VERSION:-}"; then
  USE_BASH=1
else
  USE_BASH=0
  if test -z "${ZSH_VERSION:-}"; then
    echo "256colorlib: error: this script only supports bash or zsh." >&2
    exit 1
  fi
fi

# スタイルの指定と解除
STYLE_DEFAULT=$%{'\e[0m%}'
STYLE_BOLD=$'%{\e[1m%}'
STYLE_LINE=$'%{\e[4m%}'
STYLE_NEGA=$'%{\e[7m%}'
STYLE_NOLINE=$'%{\e[24m%}'
# カラーキューブ色: 216色(16-231)
COLOR_FG_000000=$'%{\e[38;5;16m%}'
COLOR_BG_000000=$'%{\e[48;5;16m%}'
COLOR_FG_00005F=$'%{\e[38;5;17m%}'
COLOR_BG_00005F=$'%{\e[48;5;17m%}'
COLOR_FG_000087=$'%{\e[38;5;18m%}'
COLOR_BG_000087=$'%{\e[48;5;18m%}'
COLOR_FG_0000AF=$'%{\e[38;5;19m%}'
COLOR_BG_0000AF=$'%{\e[48;5;19m%}'
COLOR_FG_0000D7=$'%{\e[38;5;20m%}'
COLOR_BG_0000D7=$'%{\e[48;5;20m%}'
COLOR_FG_0000FF=$'%{\e[38;5;21m%}'
COLOR_BG_0000FF=$'%{\e[48;5;21m%}'
COLOR_FG_005F00=$'%{\e[38;5;22m%}'
COLOR_BG_005F00=$'%{\e[48;5;22m%}'
COLOR_FG_005F5F=$'%{\e[38;5;23m%}'
COLOR_BG_005F5F=$'%{\e[48;5;23m%}'
COLOR_FG_005F87=$'%{\e[38;5;24m%}'
COLOR_BG_005F87=$'%{\e[48;5;24m%}'
COLOR_FG_005FAF=$'%{\e[38;5;25m%}'
COLOR_BG_005FAF=$'%{\e[48;5;25m%}'
COLOR_FG_005FD7=$'%{\e[38;5;26m%}'
COLOR_BG_005FD7=$'%{\e[48;5;26m%}'
COLOR_FG_005FFF=$'%{\e[38;5;27m%}'
COLOR_BG_005FFF=$'%{\e[48;5;27m%}'
COLOR_FG_008700=$'%{\e[38;5;28m%}'
COLOR_BG_008700=$'%{\e[48;5;28m%}'
COLOR_FG_00875F=$'%{\e[38;5;29m%}'
COLOR_BG_00875F=$'%{\e[48;5;29m%}'
COLOR_FG_008787=$'%{\e[38;5;30m%}'
COLOR_BG_008787=$'%{\e[48;5;30m%}'
COLOR_FG_0087AF=$'%{\e[38;5;31m%}'
COLOR_BG_0087AF=$'%{\e[48;5;31m%}'
COLOR_FG_0087D7=$'%{\e[38;5;32m%}'
COLOR_BG_0087D7=$'%{\e[48;5;32m%}'
COLOR_FG_0087FF=$'%{\e[38;5;33m%}'
COLOR_BG_0087FF=$'%{\e[48;5;33m%}'
COLOR_FG_00AF00=$'%{\e[38;5;34m%}'
COLOR_BG_00AF00=$'%{\e[48;5;34m%}'
COLOR_FG_00AF5F=$'%{\e[38;5;35m%}'
COLOR_BG_00AF5F=$'%{\e[48;5;35m%}'
COLOR_FG_00AF87=$'%{\e[38;5;36m%}'
COLOR_BG_00AF87=$'%{\e[48;5;36m%}'
COLOR_FG_00AFAF=$'%{\e[38;5;37m%}'
COLOR_BG_00AFAF=$'%{\e[48;5;37m%}'
COLOR_FG_00AFD7=$'%{\e[38;5;38m%}'
COLOR_BG_00AFD7=$'%{\e[48;5;38m%}'
COLOR_FG_00AFFF=$'%{\e[38;5;39m%}'
COLOR_BG_00AFFF=$'%{\e[48;5;39m%}'
COLOR_FG_00D700=$'%{\e[38;5;40m%}'
COLOR_BG_00D700=$'%{\e[48;5;40m%}'
COLOR_FG_00D75F=$'%{\e[38;5;41m%}'
COLOR_BG_00D75F=$'%{\e[48;5;41m%}'
COLOR_FG_00D787=$'%{\e[38;5;42m%}'
COLOR_BG_00D787=$'%{\e[48;5;42m%}'
COLOR_FG_00D7AF=$'%{\e[38;5;43m%}'
COLOR_BG_00D7AF=$'%{\e[48;5;43m%}'
COLOR_FG_00D7D7=$'%{\e[38;5;44m%}'
COLOR_BG_00D7D7=$'%{\e[48;5;44m%}'
COLOR_FG_00D7FF=$'%{\e[38;5;45m%}'
COLOR_BG_00D7FF=$'%{\e[48;5;45m%}'
COLOR_FG_00FF00=$'%{\e[38;5;46m%}'
COLOR_BG_00FF00=$'%{\e[48;5;46m%}'
COLOR_FG_00FF5F=$'%{\e[38;5;47m%}'
COLOR_BG_00FF5F=$'%{\e[48;5;47m%}'
COLOR_FG_00FF87=$'%{\e[38;5;48m%}'
COLOR_BG_00FF87=$'%{\e[48;5;48m%}'
COLOR_FG_00FFAF=$'%{\e[38;5;49m%}'
COLOR_BG_00FFAF=$'%{\e[48;5;49m%}'
COLOR_FG_00FFD7=$'%{\e[38;5;50m%}'
COLOR_BG_00FFD7=$'%{\e[48;5;50m%}'
COLOR_FG_00FFFF=$'%{\e[38;5;51m%}'
COLOR_BG_00FFFF=$'%{\e[48;5;51m%}'
COLOR_FG_5F0000=$'%{\e[38;5;52m%}'
COLOR_BG_5F0000=$'%{\e[48;5;52m%}'
COLOR_FG_5F005F=$'%{\e[38;5;53m%}'
COLOR_BG_5F005F=$'%{\e[48;5;53m%}'
COLOR_FG_5F0087=$'%{\e[38;5;54m%}'
COLOR_BG_5F0087=$'%{\e[48;5;54m%}'
COLOR_FG_5F00AF=$'%{\e[38;5;55m%}'
COLOR_BG_5F00AF=$'%{\e[48;5;55m%}'
COLOR_FG_5F00D7=$'%{\e[38;5;56m%}'
COLOR_BG_5F00D7=$'%{\e[48;5;56m%}'
COLOR_FG_5F00FF=$'%{\e[38;5;57m%}'
COLOR_BG_5F00FF=$'%{\e[48;5;57m%}'
COLOR_FG_5F5F00=$'%{\e[38;5;58m%}'
COLOR_BG_5F5F00=$'%{\e[48;5;58m%}'
COLOR_FG_5F5F5F=$'%{\e[38;5;59m%}'
COLOR_BG_5F5F5F=$'%{\e[48;5;59m%}'
COLOR_FG_5F5F87=$'%{\e[38;5;60m%}'
COLOR_BG_5F5F87=$'%{\e[48;5;60m%}'
COLOR_FG_5F5FAF=$'%{\e[38;5;61m%}'
COLOR_BG_5F5FAF=$'%{\e[48;5;61m%}'
COLOR_FG_5F5FD7=$'%{\e[38;5;62m%}'
COLOR_BG_5F5FD7=$'%{\e[48;5;62m%}'
COLOR_FG_5F5FFF=$'%{\e[38;5;63m%}'
COLOR_BG_5F5FFF=$'%{\e[48;5;63m%}'
COLOR_FG_5F8700=$'%{\e[38;5;64m%}'
COLOR_BG_5F8700=$'%{\e[48;5;64m%}'
COLOR_FG_5F875F=$'%{\e[38;5;65m%}'
COLOR_BG_5F875F=$'%{\e[48;5;65m%}'
COLOR_FG_5F8787=$'%{\e[38;5;66m%}'
COLOR_BG_5F8787=$'%{\e[48;5;66m%}'
COLOR_FG_5F87AF=$'%{\e[38;5;67m%}'
COLOR_BG_5F87AF=$'%{\e[48;5;67m%}'
COLOR_FG_5F87D7=$'%{\e[38;5;68m%}'
COLOR_BG_5F87D7=$'%{\e[48;5;68m%}'
COLOR_FG_5F87FF=$'%{\e[38;5;69m%}'
COLOR_BG_5F87FF=$'%{\e[48;5;69m%}'
COLOR_FG_5FAF00=$'%{\e[38;5;70m%}'
COLOR_BG_5FAF00=$'%{\e[48;5;70m%}'
COLOR_FG_5FAF5F=$'%{\e[38;5;71m%}'
COLOR_BG_5FAF5F=$'%{\e[48;5;71m%}'
COLOR_FG_5FAF87=$'%{\e[38;5;72m%}'
COLOR_BG_5FAF87=$'%{\e[48;5;72m%}'
COLOR_FG_5FAFAF=$'%{\e[38;5;73m%}'
COLOR_BG_5FAFAF=$'%{\e[48;5;73m%}'
COLOR_FG_5FAFD7=$'%{\e[38;5;74m%}'
COLOR_BG_5FAFD7=$'%{\e[48;5;74m%}'
COLOR_FG_5FAFFF=$'%{\e[38;5;75m%}'
COLOR_BG_5FAFFF=$'%{\e[48;5;75m%}'
COLOR_FG_5FD700=$'%{\e[38;5;76m%}'
COLOR_BG_5FD700=$'%{\e[48;5;76m%}'
COLOR_FG_5FD75F=$'%{\e[38;5;77m%}'
COLOR_BG_5FD75F=$'%{\e[48;5;77m%}'
COLOR_FG_5FD787=$'%{\e[38;5;78m%}'
COLOR_BG_5FD787=$'%{\e[48;5;78m%}'
COLOR_FG_5FD7AF=$'%{\e[38;5;79m%}'
COLOR_BG_5FD7AF=$'%{\e[48;5;79m%}'
COLOR_FG_5FD7D7=$'%{\e[38;5;80m%}'
COLOR_BG_5FD7D7=$'%{\e[48;5;80m%}'
COLOR_FG_5FD7FF=$'%{\e[38;5;81m%}'
COLOR_BG_5FD7FF=$'%{\e[48;5;81m%}'
COLOR_FG_5FFF00=$'%{\e[38;5;82m%}'
COLOR_BG_5FFF00=$'%{\e[48;5;82m%}'
COLOR_FG_5FFF5F=$'%{\e[38;5;83m%}'
COLOR_BG_5FFF5F=$'%{\e[48;5;83m%}'
COLOR_FG_5FFF87=$'%{\e[38;5;84m%}'
COLOR_BG_5FFF87=$'%{\e[48;5;84m%}'
COLOR_FG_5FFFAF=$'%{\e[38;5;85m%}'
COLOR_BG_5FFFAF=$'%{\e[48;5;85m%}'
COLOR_FG_5FFFD7=$'%{\e[38;5;86m%}'
COLOR_BG_5FFFD7=$'%{\e[48;5;86m%}'
COLOR_FG_5FFFFF=$'%{\e[38;5;87m%}'
COLOR_BG_5FFFFF=$'%{\e[48;5;87m%}'
COLOR_FG_870000=$'%{\e[38;5;88m%}'
COLOR_BG_870000=$'%{\e[48;5;88m%}'
COLOR_FG_87005F=$'%{\e[38;5;89m%}'
COLOR_BG_87005F=$'%{\e[48;5;89m%}'
COLOR_FG_870087=$'%{\e[38;5;90m%}'
COLOR_BG_870087=$'%{\e[48;5;90m%}'
COLOR_FG_8700AF=$'%{\e[38;5;91m%}'
COLOR_BG_8700AF=$'%{\e[48;5;91m%}'
COLOR_FG_8700D7=$'%{\e[38;5;92m%}'
COLOR_BG_8700D7=$'%{\e[48;5;92m%}'
COLOR_FG_8700FF=$'%{\e[38;5;93m%}'
COLOR_BG_8700FF=$'%{\e[48;5;93m%}'
COLOR_FG_875F00=$'%{\e[38;5;94m%}'
COLOR_BG_875F00=$'%{\e[48;5;94m%}'
COLOR_FG_875F5F=$'%{\e[38;5;95m%}'
COLOR_BG_875F5F=$'%{\e[48;5;95m%}'
COLOR_FG_875F87=$'%{\e[38;5;96m%}'
COLOR_BG_875F87=$'%{\e[48;5;96m%}'
COLOR_FG_875FAF=$'%{\e[38;5;97m%}'
COLOR_BG_875FAF=$'%{\e[48;5;97m%}'
COLOR_FG_875FD7=$'%{\e[38;5;98m%}'
COLOR_BG_875FD7=$'%{\e[48;5;98m%}'
COLOR_FG_875FFF=$'%{\e[38;5;99m%}'
COLOR_BG_875FFF=$'%{\e[48;5;99m%}'
COLOR_FG_878700=$'%{\e[38;5;100m%}'
COLOR_BG_878700=$'%{\e[48;5;100m%}'
COLOR_FG_87875F=$'%{\e[38;5;101m%}'
COLOR_BG_87875F=$'%{\e[48;5;101m%}'
COLOR_FG_878787=$'%{\e[38;5;102m%}'
COLOR_BG_878787=$'%{\e[48;5;102m%}'
COLOR_FG_8787AF=$'%{\e[38;5;103m%}'
COLOR_BG_8787AF=$'%{\e[48;5;103m%}'
COLOR_FG_8787D7=$'%{\e[38;5;104m%}'
COLOR_BG_8787D7=$'%{\e[48;5;104m%}'
COLOR_FG_8787FF=$'%{\e[38;5;105m%}'
COLOR_BG_8787FF=$'%{\e[48;5;105m%}'
COLOR_FG_87AF00=$'%{\e[38;5;106m%}'
COLOR_BG_87AF00=$'%{\e[48;5;106m%}'
COLOR_FG_87AF5F=$'%{\e[38;5;107m%}'
COLOR_BG_87AF5F=$'%{\e[48;5;107m%}'
COLOR_FG_87AF87=$'%{\e[38;5;108m%}'
COLOR_BG_87AF87=$'%{\e[48;5;108m%}'
COLOR_FG_87AFAF=$'%{\e[38;5;109m%}'
COLOR_BG_87AFAF=$'%{\e[48;5;109m%}'
COLOR_FG_87AFD7=$'%{\e[38;5;110m%}'
COLOR_BG_87AFD7=$'%{\e[48;5;110m%}'
COLOR_FG_87AFFF=$'%{\e[38;5;111m%}'
COLOR_BG_87AFFF=$'%{\e[48;5;111m%}'
COLOR_FG_87D700=$'%{\e[38;5;112m%}'
COLOR_BG_87D700=$'%{\e[48;5;112m%}'
COLOR_FG_87D75F=$'%{\e[38;5;113m%}'
COLOR_BG_87D75F=$'%{\e[48;5;113m%}'
COLOR_FG_87D787=$'%{\e[38;5;114m%}'
COLOR_BG_87D787=$'%{\e[48;5;114m%}'
COLOR_FG_87D7AF=$'%{\e[38;5;115m%}'
COLOR_BG_87D7AF=$'%{\e[48;5;115m%}'
COLOR_FG_87D7D7=$'%{\e[38;5;116m%}'
COLOR_BG_87D7D7=$'%{\e[48;5;116m%}'
COLOR_FG_87D7FF=$'%{\e[38;5;117m%}'
COLOR_BG_87D7FF=$'%{\e[48;5;117m%}'
COLOR_FG_87FF00=$'%{\e[38;5;118m%}'
COLOR_BG_87FF00=$'%{\e[48;5;118m%}'
COLOR_FG_87FF5F=$'%{\e[38;5;119m%}'
COLOR_BG_87FF5F=$'%{\e[48;5;119m%}'
COLOR_FG_87FF87=$'%{\e[38;5;120m%}'
COLOR_BG_87FF87=$'%{\e[48;5;120m%}'
COLOR_FG_87FFAF=$'%{\e[38;5;121m%}'
COLOR_BG_87FFAF=$'%{\e[48;5;121m%}'
COLOR_FG_87FFD7=$'%{\e[38;5;122m%}'
COLOR_BG_87FFD7=$'%{\e[48;5;122m%}'
COLOR_FG_87FFFF=$'%{\e[38;5;123m%}'
COLOR_BG_87FFFF=$'%{\e[48;5;123m%}'
COLOR_FG_AF0000=$'%{\e[38;5;124m%}'
COLOR_BG_AF0000=$'%{\e[48;5;124m%}'
COLOR_FG_AF005F=$'%{\e[38;5;125m%}'
COLOR_BG_AF005F=$'%{\e[48;5;125m%}'
COLOR_FG_AF0087=$'%{\e[38;5;126m%}'
COLOR_BG_AF0087=$'%{\e[48;5;126m%}'
COLOR_FG_AF00AF=$'%{\e[38;5;127m%}'
COLOR_BG_AF00AF=$'%{\e[48;5;127m%}'
COLOR_FG_AF00D7=$'%{\e[38;5;128m%}'
COLOR_BG_AF00D7=$'%{\e[48;5;128m%}'
COLOR_FG_AF00FF=$'%{\e[38;5;129m%}'
COLOR_BG_AF00FF=$'%{\e[48;5;129m%}'
COLOR_FG_AF5F00=$'%{\e[38;5;130m%}'
COLOR_BG_AF5F00=$'%{\e[48;5;130m%}'
COLOR_FG_AF5F5F=$'%{\e[38;5;131m%}'
COLOR_BG_AF5F5F=$'%{\e[48;5;131m%}'
COLOR_FG_AF5F87=$'%{\e[38;5;132m%}'
COLOR_BG_AF5F87=$'%{\e[48;5;132m%}'
COLOR_FG_AF5FAF=$'%{\e[38;5;133m%}'
COLOR_BG_AF5FAF=$'%{\e[48;5;133m%}'
COLOR_FG_AF5FD7=$'%{\e[38;5;134m%}'
COLOR_BG_AF5FD7=$'%{\e[48;5;134m%}'
COLOR_FG_AF5FFF=$'%{\e[38;5;135m%}'
COLOR_BG_AF5FFF=$'%{\e[48;5;135m%}'
COLOR_FG_AF8700=$'%{\e[38;5;136m%}'
COLOR_BG_AF8700=$'%{\e[48;5;136m%}'
COLOR_FG_AF875F=$'%{\e[38;5;137m%}'
COLOR_BG_AF875F=$'%{\e[48;5;137m%}'
COLOR_FG_AF8787=$'%{\e[38;5;138m%}'
COLOR_BG_AF8787=$'%{\e[48;5;138m%}'
COLOR_FG_AF87AF=$'%{\e[38;5;139m%}'
COLOR_BG_AF87AF=$'%{\e[48;5;139m%}'
COLOR_FG_AF87D7=$'%{\e[38;5;140m%}'
COLOR_BG_AF87D7=$'%{\e[48;5;140m%}'
COLOR_FG_AF87FF=$'%{\e[38;5;141m%}'
COLOR_BG_AF87FF=$'%{\e[48;5;141m%}'
COLOR_FG_AFAF00=$'%{\e[38;5;142m%}'
COLOR_BG_AFAF00=$'%{\e[48;5;142m%}'
COLOR_FG_AFAF5F=$'%{\e[38;5;143m%}'
COLOR_BG_AFAF5F=$'%{\e[48;5;143m%}'
COLOR_FG_AFAF87=$'%{\e[38;5;144m%}'
COLOR_BG_AFAF87=$'%{\e[48;5;144m%}'
COLOR_FG_AFAFAF=$'%{\e[38;5;145m%}'
COLOR_BG_AFAFAF=$'%{\e[48;5;145m%}'
COLOR_FG_AFAFD7=$'%{\e[38;5;146m%}'
COLOR_BG_AFAFD7=$'%{\e[48;5;146m%}'
COLOR_FG_AFAFFF=$'%{\e[38;5;147m%}'
COLOR_BG_AFAFFF=$'%{\e[48;5;147m%}'
COLOR_FG_AFD700=$'%{\e[38;5;148m%}'
COLOR_BG_AFD700=$'%{\e[48;5;148m%}'
COLOR_FG_AFD75F=$'%{\e[38;5;149m%}'
COLOR_BG_AFD75F=$'%{\e[48;5;149m%}'
COLOR_FG_AFD787=$'%{\e[38;5;150m%}'
COLOR_BG_AFD787=$'%{\e[48;5;150m%}'
COLOR_FG_AFD7AF=$'%{\e[38;5;151m%}'
COLOR_BG_AFD7AF=$'%{\e[48;5;151m%}'
COLOR_FG_AFD7D7=$'%{\e[38;5;152m%}'
COLOR_BG_AFD7D7=$'%{\e[48;5;152m%}'
COLOR_FG_AFD7FF=$'%{\e[38;5;153m%}'
COLOR_BG_AFD7FF=$'%{\e[48;5;153m%}'
COLOR_FG_AFFF00=$'%{\e[38;5;154m%}'
COLOR_BG_AFFF00=$'%{\e[48;5;154m%}'
COLOR_FG_AFFF5F=$'%{\e[38;5;155m%}'
COLOR_BG_AFFF5F=$'%{\e[48;5;155m%}'
COLOR_FG_AFFF87=$'%{\e[38;5;156m%}'
COLOR_BG_AFFF87=$'%{\e[48;5;156m%}'
COLOR_FG_AFFFAF=$'%{\e[38;5;157m%}'
COLOR_BG_AFFFAF=$'%{\e[48;5;157m%}'
COLOR_FG_AFFFD7=$'%{\e[38;5;158m%}'
COLOR_BG_AFFFD7=$'%{\e[48;5;158m%}'
COLOR_FG_AFFFFF=$'%{\e[38;5;159m%}'
COLOR_BG_AFFFFF=$'%{\e[48;5;159m%}'
COLOR_FG_D70000=$'%{\e[38;5;160m%}'
COLOR_BG_D70000=$'%{\e[48;5;160m%}'
COLOR_FG_D7005F=$'%{\e[38;5;161m%}'
COLOR_BG_D7005F=$'%{\e[48;5;161m%}'
COLOR_FG_D70087=$'%{\e[38;5;162m%}'
COLOR_BG_D70087=$'%{\e[48;5;162m%}'
COLOR_FG_D700AF=$'%{\e[38;5;163m%}'
COLOR_BG_D700AF=$'%{\e[48;5;163m%}'
COLOR_FG_D700D7=$'%{\e[38;5;164m%}'
COLOR_BG_D700D7=$'%{\e[48;5;164m%}'
COLOR_FG_D700FF=$'%{\e[38;5;165m%}'
COLOR_BG_D700FF=$'%{\e[48;5;165m%}'
COLOR_FG_D75F00=$'%{\e[38;5;166m%}'
COLOR_BG_D75F00=$'%{\e[48;5;166m%}'
COLOR_FG_D75F5F=$'%{\e[38;5;167m%}'
COLOR_BG_D75F5F=$'%{\e[48;5;167m%}'
COLOR_FG_D75F87=$'%{\e[38;5;168m%}'
COLOR_BG_D75F87=$'%{\e[48;5;168m%}'
COLOR_FG_D75FAF=$'%{\e[38;5;169m%}'
COLOR_BG_D75FAF=$'%{\e[48;5;169m%}'
COLOR_FG_D75FD7=$'%{\e[38;5;170m%}'
COLOR_BG_D75FD7=$'%{\e[48;5;170m%}'
COLOR_FG_D75FFF=$'%{\e[38;5;171m%}'
COLOR_BG_D75FFF=$'%{\e[48;5;171m%}'
COLOR_FG_D78700=$'%{\e[38;5;172m%}'
COLOR_BG_D78700=$'%{\e[48;5;172m%}'
COLOR_FG_D7875F=$'%{\e[38;5;173m%}'
COLOR_BG_D7875F=$'%{\e[48;5;173m%}'
COLOR_FG_D78787=$'%{\e[38;5;174m%}'
COLOR_BG_D78787=$'%{\e[48;5;174m%}'
COLOR_FG_D787AF=$'%{\e[38;5;175m%}'
COLOR_BG_D787AF=$'%{\e[48;5;175m%}'
COLOR_FG_D787D7=$'%{\e[38;5;176m%}'
COLOR_BG_D787D7=$'%{\e[48;5;176m%}'
COLOR_FG_D787FF=$'%{\e[38;5;177m%}'
COLOR_BG_D787FF=$'%{\e[48;5;177m%}'
COLOR_FG_D7AF00=$'%{\e[38;5;178m%}'
COLOR_BG_D7AF00=$'%{\e[48;5;178m%}'
COLOR_FG_D7AF5F=$'%{\e[38;5;179m%}'
COLOR_BG_D7AF5F=$'%{\e[48;5;179m%}'
COLOR_FG_D7AF87=$'%{\e[38;5;180m%}'
COLOR_BG_D7AF87=$'%{\e[48;5;180m%}'
COLOR_FG_D7AFAF=$'%{\e[38;5;181m%}'
COLOR_BG_D7AFAF=$'%{\e[48;5;181m%}'
COLOR_FG_D7AFD7=$'%{\e[38;5;182m%}'
COLOR_BG_D7AFD7=$'%{\e[48;5;182m%}'
COLOR_FG_D7AFFF=$'%{\e[38;5;183m%}'
COLOR_BG_D7AFFF=$'%{\e[48;5;183m%}'
COLOR_FG_D7D700=$'%{\e[38;5;184m%}'
COLOR_BG_D7D700=$'%{\e[48;5;184m%}'
COLOR_FG_D7D75F=$'%{\e[38;5;185m%}'
COLOR_BG_D7D75F=$'%{\e[48;5;185m%}'
COLOR_FG_D7D787=$'%{\e[38;5;186m%}'
COLOR_BG_D7D787=$'%{\e[48;5;186m%}'
COLOR_FG_D7D7AF=$'%{\e[38;5;187m%}'
COLOR_BG_D7D7AF=$'%{\e[48;5;187m%}'
COLOR_FG_D7D7D7=$'%{\e[38;5;188m%}'
COLOR_BG_D7D7D7=$'%{\e[48;5;188m%}'
COLOR_FG_D7D7FF=$'%{\e[38;5;189m%}'
COLOR_BG_D7D7FF=$'%{\e[48;5;189m%}'
COLOR_FG_D7FF00=$'%{\e[38;5;190m%}'
COLOR_BG_D7FF00=$'%{\e[48;5;190m%}'
COLOR_FG_D7FF5F=$'%{\e[38;5;191m%}'
COLOR_BG_D7FF5F=$'%{\e[48;5;191m%}'
COLOR_FG_D7FF87=$'%{\e[38;5;192m%}'
COLOR_BG_D7FF87=$'%{\e[48;5;192m%}'
COLOR_FG_D7FFAF=$'%{\e[38;5;193m%}'
COLOR_BG_D7FFAF=$'%{\e[48;5;193m%}'
COLOR_FG_D7FFD7=$'%{\e[38;5;194m%}'
COLOR_BG_D7FFD7=$'%{\e[48;5;194m%}'
COLOR_FG_D7FFFF=$'%{\e[38;5;195m%}'
COLOR_BG_D7FFFF=$'%{\e[48;5;195m%}'
COLOR_FG_FF0000=$'%{\e[38;5;196m%}'
COLOR_BG_FF0000=$'%{\e[48;5;196m%}'
COLOR_FG_FF005F=$'%{\e[38;5;197m%}'
COLOR_BG_FF005F=$'%{\e[48;5;197m%}'
COLOR_FG_FF0087=$'%{\e[38;5;198m%}'
COLOR_BG_FF0087=$'%{\e[48;5;198m%}'
COLOR_FG_FF00AF=$'%{\e[38;5;199m%}'
COLOR_BG_FF00AF=$'%{\e[48;5;199m%}'
COLOR_FG_FF00D7=$'%{\e[38;5;200m%}'
COLOR_BG_FF00D7=$'%{\e[48;5;200m%}'
COLOR_FG_FF00FF=$'%{\e[38;5;201m%}'
COLOR_BG_FF00FF=$'%{\e[48;5;201m%}'
COLOR_FG_FF5F00=$'%{\e[38;5;202m%}'
COLOR_BG_FF5F00=$'%{\e[48;5;202m%}'
COLOR_FG_FF5F5F=$'%{\e[38;5;203m%}'
COLOR_BG_FF5F5F=$'%{\e[48;5;203m%}'
COLOR_FG_FF5F87=$'%{\e[38;5;204m%}'
COLOR_BG_FF5F87=$'%{\e[48;5;204m%}'
COLOR_FG_FF5FAF=$'%{\e[38;5;205m%}'
COLOR_BG_FF5FAF=$'%{\e[48;5;205m%}'
COLOR_FG_FF5FD7=$'%{\e[38;5;206m%}'
COLOR_BG_FF5FD7=$'%{\e[48;5;206m%}'
COLOR_FG_FF5FFF=$'%{\e[38;5;207m%}'
COLOR_BG_FF5FFF=$'%{\e[48;5;207m%}'
COLOR_FG_FF8700=$'%{\e[38;5;208m%}'
COLOR_BG_FF8700=$'%{\e[48;5;208m%}'
COLOR_FG_FF875F=$'%{\e[38;5;209m%}'
COLOR_BG_FF875F=$'%{\e[48;5;209m%}'
COLOR_FG_FF8787=$'%{\e[38;5;210m%}'
COLOR_BG_FF8787=$'%{\e[48;5;210m%}'
COLOR_FG_FF87AF=$'%{\e[38;5;211m%}'
COLOR_BG_FF87AF=$'%{\e[48;5;211m%}'
COLOR_FG_FF87D7=$'%{\e[38;5;212m%}'
COLOR_BG_FF87D7=$'%{\e[48;5;212m%}'
COLOR_FG_FF87FF=$'%{\e[38;5;213m%}'
COLOR_BG_FF87FF=$'%{\e[48;5;213m%}'
COLOR_FG_FFAF00=$'%{\e[38;5;214m%}'
COLOR_BG_FFAF00=$'%{\e[48;5;214m%}'
COLOR_FG_FFAF5F=$'%{\e[38;5;215m%}'
COLOR_BG_FFAF5F=$'%{\e[48;5;215m%}'
COLOR_FG_FFAF87=$'%{\e[38;5;216m%}'
COLOR_BG_FFAF87=$'%{\e[48;5;216m%}'
COLOR_FG_FFAFAF=$'%{\e[38;5;217m%}'
COLOR_BG_FFAFAF=$'%{\e[48;5;217m%}'
COLOR_FG_FFAFD7=$'%{\e[38;5;218m%}'
COLOR_BG_FFAFD7=$'%{\e[48;5;218m%}'
COLOR_FG_FFAFFF=$'%{\e[38;5;219m%}'
COLOR_BG_FFAFFF=$'%{\e[48;5;219m%}'
COLOR_FG_FFD700=$'%{\e[38;5;220m%}'
COLOR_BG_FFD700=$'%{\e[48;5;220m%}'
COLOR_FG_FFD75F=$'%{\e[38;5;221m%}'
COLOR_BG_FFD75F=$'%{\e[48;5;221m%}'
COLOR_FG_FFD787=$'%{\e[38;5;222m%}'
COLOR_BG_FFD787=$'%{\e[48;5;222m%}'
COLOR_FG_FFD7AF=$'%{\e[38;5;223m%}'
COLOR_BG_FFD7AF=$'%{\e[48;5;223m%}'
COLOR_FG_FFD7D7=$'%{\e[38;5;224m%}'
COLOR_BG_FFD7D7=$'%{\e[48;5;224m%}'
COLOR_FG_FFD7FF=$'%{\e[38;5;225m%}'
COLOR_BG_FFD7FF=$'%{\e[48;5;225m%}'
COLOR_FG_FFFF00=$'%{\e[38;5;226m%}'
COLOR_BG_FFFF00=$'%{\e[48;5;226m%}'
COLOR_FG_FFFF5F=$'%{\e[38;5;227m%}'
COLOR_BG_FFFF5F=$'%{\e[48;5;227m%}'
COLOR_FG_FFFF87=$'%{\e[38;5;228m%}'
COLOR_BG_FFFF87=$'%{\e[48;5;228m%}'
COLOR_FG_FFFFAF=$'%{\e[38;5;229m%}'
COLOR_BG_FFFFAF=$'%{\e[48;5;229m%}'
COLOR_FG_FFFFD7=$'%{\e[38;5;230m%}'
COLOR_BG_FFFFD7=$'%{\e[48;5;230m%}'
COLOR_FG_FFFFFF=$'%{\e[38;5;231m%}'
COLOR_BG_FFFFFF=$'%{\e[48;5;231m%}'

# グレースケール色: 24色(232-255)
COLOR_FG_080808=$'%{\e[38;5;232m%}'
COLOR_BG_080808=$'%{\e[48;5;232m%}'
COLOR_FG_121212=$'%{\e[38;5;233m%}'
COLOR_BG_121212=$'%{\e[48;5;233m%}'
COLOR_FG_1C1C1C=$'%{\e[38;5;234m%}'
COLOR_BG_1C1C1C=$'%{\e[48;5;234m%}'
COLOR_FG_262626=$'%{\e[38;5;235m%}'
COLOR_BG_262626=$'%{\e[48;5;235m%}'
COLOR_FG_303030=$'%{\e[38;5;236m%}'
COLOR_BG_303030=$'%{\e[48;5;236m%}'
COLOR_FG_3A3A3A=$'%{\e[38;5;237m%}'
COLOR_BG_3A3A3A=$'%{\e[48;5;237m%}'
COLOR_FG_444444=$'%{\e[38;5;238m%}'
COLOR_BG_444444=$'%{\e[48;5;238m%}'
COLOR_FG_4E4E4E=$'%{\e[38;5;239m%}'
COLOR_BG_4E4E4E=$'%{\e[48;5;239m%}'
COLOR_FG_585858=$'%{\e[38;5;240m%}'
COLOR_BG_585858=$'%{\e[48;5;240m%}'
COLOR_FG_626262=$'%{\e[38;5;241m%}'
COLOR_BG_626262=$'%{\e[48;5;241m%}'
COLOR_FG_6C6C6C=$'%{\e[38;5;242m%}'
COLOR_BG_6C6C6C=$'%{\e[48;5;242m%}'
COLOR_FG_767676=$'%{\e[38;5;243m%}'
COLOR_BG_767676=$'%{\e[48;5;243m%}'
COLOR_FG_808080=$'%{\e[38;5;244m%}'
COLOR_BG_808080=$'%{\e[48;5;244m%}'
COLOR_FG_8A8A8A=$'%{\e[38;5;245m%}'
COLOR_BG_8A8A8A=$'%{\e[48;5;245m%}'
COLOR_FG_949494=$'%{\e[38;5;246m%}'
COLOR_BG_949494=$'%{\e[48;5;246m%}'
COLOR_FG_9E9E9E=$'%{\e[38;5;247m%}'
COLOR_BG_9E9E9E=$'%{\e[48;5;247m%}'
COLOR_FG_A8A8A8=$'%{\e[38;5;248m%}'
COLOR_BG_A8A8A8=$'%{\e[48;5;248m%}'
COLOR_FG_B2B2B2=$'%{\e[38;5;249m%}'
COLOR_BG_B2B2B2=$'%{\e[48;5;249m%}'
COLOR_FG_BCBCBC=$'%{\e[38;5;250m%}'
COLOR_BG_BCBCBC=$'%{\e[48;5;250m%}'
COLOR_FG_C6C6C6=$'%{\e[38;5;251m%}'
COLOR_BG_C6C6C6=$'%{\e[48;5;251m%}'
COLOR_FG_D0D0D0=$'%{\e[38;5;252m%}'
COLOR_BG_D0D0D0=$'%{\e[48;5;252m%}'
COLOR_FG_DADADA=$'%{\e[38;5;253m%}'
COLOR_BG_DADADA=$'%{\e[48;5;253m%}'
COLOR_FG_E4E4E4=$'%{\e[38;5;254m%}'
COLOR_BG_E4E4E4=$'%{\e[48;5;254m%}'
COLOR_FG_EEEEEE=$'%{\e[38;5;255m%}'
COLOR_BG_EEEEEE=$'%{\e[48;5;255m%}'

# [EOF]
