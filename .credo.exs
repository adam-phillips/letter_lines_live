# .credo.exs config
%{
  configs: [
    %{
      # Run any config using `mix credo -C <name>`. If no config name is given "default" is used.
      name: "default",
      files: %{
        #
        # You can give explicit globs or simply directories.
        # In the latter case `**/*.{ex,exs}` will be used.
        #
        included: [
          "lib/",
          "src/",
          "test/",
          "web/",
          "apps/*/lib/",
          "apps/*/src/",
          "apps/*/test/",
          "apps/*/web/"
        ],
        excluded: [~r"/_build/", ~r"/deps/", ~r"/node_modules/"]
      },
      # Load and configure plugins here:
      plugins: [],
      # If you create your own checks, you must specify the source files for
      # them here, so they can be loaded by Credo before running the analysis.
      requires: [],
      # If you want to enforce a style guide and need a more traditional linting
      # experience, you can change `strict` to `true` below:
      strict: true,
      # To modify the timeout for parsing files, change this value:
      parse_timeout: 5000,
      # If you want to use uncolored output by default, you can change `color`
      # to `false` below:
      color: true,
      # You can customize the parameters of any check by adding a second element
      # to the tuple.
      #
      # To disable a check put `false` as second element:
      #
      #     {Credo.Check.Design.DuplicatedCode, false}
      #
      # Otherwise, the check is enabled
      checks: [
        ## Consistency Checks
        {Credo.Check.Consistency.ExceptionNames, []},
        {Credo.Check.Consistency.LineEndings, []},
        {Credo.Check.Consistency.ParameterPatternMatching, []},
        {Credo.Check.Consistency.SpaceAroundOperators, []},
        {Credo.Check.Consistency.SpaceInParentheses, []},
        {Credo.Check.Consistency.TabsOrSpaces, []},

        ## Design Checks

        # You can customize the priority of any check
        # Priority values are: `low, normal, high, higher`
        {Credo.Check.Design.AliasUsage,
         [priority: :low, if_nested_deeper_than: 2, if_called_more_often_than: 1]},

        # You can also customize the exit_status of each check.
        # If you don't want TODO comments to cause `mix credo` to fail, just
        # set this value to 0 (zero).
        {Credo.Check.Design.TagTODO, [include_doc: true, exit_status: 2]},
        {Credo.Check.Design.TagFIXME, [include_doc: true, exit_status: 2]},

        ## Readability Checks
        {Credo.Check.Readability.AliasAs, []},
        {Credo.Check.Readability.AliasOrder, []},
        {Credo.Check.Readability.FunctionNames, []},
        {Credo.Check.Readability.LargeNumbers, []},
        {Credo.Check.Readability.MaxLineLength, [priority: :low, max_length: 120]},
        {Credo.Check.Readability.ModuleAttributeNames, []},
        {Credo.Check.Readability.ModuleDoc, []},
        {Credo.Check.Readability.ModuleNames, []},
        {Credo.Check.Readability.ParenthesesInCondition, []},
        {Credo.Check.Readability.ParenthesesOnZeroArityDefs, []},
        {Credo.Check.Readability.PredicateFunctionNames, []},
        {Credo.Check.Readability.PreferImplicitTry, []},
        {Credo.Check.Readability.RedundantBlankLines, []},
        {Credo.Check.Readability.Semicolons, []},
        {Credo.Check.Readability.SpaceAfterCommas, [priority: :low]},
        {Credo.Check.Readability.StringSigils, []},
        {Credo.Check.Readability.TrailingBlankLine, []},
        {Credo.Check.Readability.TrailingWhiteSpace, []},
        {Credo.Check.Readability.UnnecessaryAliasExpansion, []},
        {Credo.Check.Readability.VariableNames, []},

        #
        ## Refactoring Opportunities
        #
        {Credo.Check.Refactor.CondStatements, []},
        {Credo.Check.Refactor.CyclomaticComplexity, []},
        {Credo.Check.Refactor.FunctionArity, []},
        {Credo.Check.Refactor.LongQuoteBlocks, []},
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Refactor.MatchInCondition, []},
        {Credo.Check.Refactor.NegatedConditionsInUnless, []},
        {Credo.Check.Refactor.NegatedConditionsWithElse, []},
        {Credo.Check.Refactor.Nesting, []},
        {Credo.Check.Refactor.UnlessWithElse, []},
        {Credo.Check.Refactor.WithClauses, []},

        #
        ## Warnings
        #
        {Credo.Check.Warning.BoolOperationOnSameValues, []},
        {Credo.Check.Warning.ExpensiveEmptyEnumCheck, []},
        {Credo.Check.Warning.IExPry, []},
        {Credo.Check.Warning.IoInspect, []},
        {Credo.Check.Warning.LazyLogging, false},
        {Credo.Check.Warning.MixEnv, []},
        {Credo.Check.Warning.OperationOnSameValues, []},
        {Credo.Check.Warning.OperationWithConstantResult, []},
        {Credo.Check.Warning.RaiseInsideRescue, []},
        {Credo.Check.Warning.UnusedEnumOperation, []},
        {Credo.Check.Warning.UnusedFileOperation, []},
        {Credo.Check.Warning.UnusedKeywordOperation, []},
        {Credo.Check.Warning.UnusedListOperation, []},
        {Credo.Check.Warning.UnusedPathOperation, []},
        {Credo.Check.Warning.UnusedRegexOperation, []},
        {Credo.Check.Warning.UnusedStringOperation, []},
        {Credo.Check.Warning.UnusedTupleOperation, []},
        {Credo.Check.Warning.UnsafeExec, []},

        #
        # Checks scheduled for next check update (opt-in for now, just replace `false` with `[]`)

        #
        # Controversial and experimental checks (opt-in, just replace `false` with `[]`)
        #
        {Credo.Check.Readability.StrictModuleLayout, false},
        {Credo.Check.Consistency.MultiAliasImportRequireUse, false},
        {Credo.Check.Consistency.UnusedVariableNames, false},
        {Credo.Check.Design.DuplicatedCode, false},
        {Credo.Check.Readability.AliasAs, false},
        {Credo.Check.Readability.MultiAlias, []},
        #        {Credo.Check.Readability.Specs, []}, # TODO: handle this so it can be used
        {Credo.Check.Readability.SinglePipe, []},
        {Credo.Check.Readability.WithCustomTaggedTuple, []},
        {Credo.Check.Refactor.ABCSize, false},
        {Credo.Check.Refactor.AppendSingleItem, []},
        {Credo.Check.Refactor.DoubleBooleanNegation, []},
        {Credo.Check.Refactor.ModuleDependencies, [max_deps: 30]},
        {Credo.Check.Refactor.NegatedIsNil, false},
        {Credo.Check.Refactor.PipeChainStart, []},
        {Credo.Check.Refactor.VariableRebinding, false},
        {Credo.Check.Warning.LeakyEnvironment, []},
        {Credo.Check.Warning.MapGetUnsafePass, []},
        {Credo.Check.Warning.UnsafeToAtom, []}

        #
        # Custom checks can be created using `mix credo.gen.check`.
        #
      ]
    }
  ]
}
