#include "head.h"

int main() {
    string Regular_Expression;
    input(Regular_Expression);
    vector<string> RE_strs = preprocess(Regular_Expression);
    if (RE_strs.size() > 1)
        RE_strs = add_join_symbol(RE_strs);
    infixToPostfix Solution(RE_strs);
    //中缀转后缀
    RE_strs = Solution.getResult();
    //表达式转NFA
    elem NFA_Elem = express_to_NFA(RE_strs);
    //显示
    Display(NFA_Elem);
    //生成NFAdot文件
    generateDotFile_NFA(NFA_Elem);

    // 初始化 DFA 状态集合和转换关系
    vector<DFAState> dfaStates; //用于存储所有的DFA状态
    vector<DFATransition> dfaTransitions; //用于存储DFA状态之间的转移
    set<string> nfaInitialStateSet;   //存储NFA的初始状态
    buildDFAFromNFA(NFA_Elem, dfaStates, dfaTransitions);//从NFA构造DFA
    // 显示 DFA
    displayDFA(dfaStates, dfaTransitions);

    //生成DFAdot文件
    generateDotFile_DFA(dfaStates,dfaTransitions);
    return 0;
}
