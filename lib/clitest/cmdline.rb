# frozen_string_literal: true

# コマンドラインテスト用クラスの名前空間
module Clitest
  require "pathname"

  # コマンドラインテスト用のコマンドライン作成クラス
  # @author Yasuo Kominami
  # @since 0.1.0
  # @attr_reader [Pathname] test_cmd_path_pn 実行ファイルを呼び出すシェルスクリプトへのパス
  class Cmdline
    attr_reader :test_cmd_path_pn

    # 実行ファイルを呼び出すシェルスクリプトのファイル名
    #　　シェルスクリプトの引数
    #   test_root_dir: 実行ファイルを呼び出す時のディレクトリのルートディレクトリ(このディレクトリのサブディレクトリで呼び出す)
    #   result_file: 実行ファイルの実行結果を格納するファイルの名前
    #   target_cmd: 実行ファイルの名前（ここで指定した名前で実行ファイルを呼び出せる必要がある-絶対パスまたは環境変数PATHでパスが指定されていること）
    #   target_dir: 実行ファイルを呼び出すときのディレクトリ（test_root_dirからの相対パス）
    CMD = "clitest"

    # Cmdlineクラスのコンストラクタ
    # @param [String] bin_dir 実行ファイルを呼び出すシェルスクリプトを置くbinディレクトリ
    # @param [String] cmd_name 実行ファイルを呼び出すシェルスクリプト名
    # @param [String] test_dir テストを実行するディレクトリ（@test_dir_pnaからの相対パス）
    # @param [Array] target_cmds 実行ファイル名の配列（ここで指定した名前で実行ファイルを呼び出せる必要がある-絶対パスまたは環境変数PATHでパスが指定されていること）
    def initialize(bin_dir, cmd_name, test_dir, *target_cmds)
      bin_dir = nil if bin_dir =~ /^\s*$/
      if bin_dir
        bin_dir_pn = Pathname.new(bin_dir)
        bin_dir_pn = nil unless bin_dir_pn.exist?
      end
      bin_dir_pn ||= BIN_DIR_PN
      cmd_name ||= CMD
      @test_cmd_path_pn = bin_dir_pn.join(cmd_name)
      @test_dir_pn = Pathname.new(test_dir)
      @target_cmds = target_cmds
    end

    # 実行ファイル用コマンドライン作成
    # @param [String] target_cmd 実行ファイル
    # @param [String] target_dir テスト実行ディレクトリ（@test_dir_pnaからの相対パス）
    # @param [String] result_file 実行ファイルの実行結果を格納するファイルの名前
    # @param [Array] optionx （付加的な）コマンドラインオプション
    # @param [Array] param_names コマンドラインオプション群
    # @return [String] コマンドライン文字列
    def make_cmdline_base(target_cmd, target_dir, result_file, optionx, *param_names)
      params = param_names.join(" ")

      "#{@test_cmd_path_pn} #{@test_dir_pn} #{result_file} #{target_cmd} #{target_dir} #{optionx} #{params}"
    end

    # 実行ファイル番号による実行ファイル用コマンドライン作成
    # @param [String] cmd_index 実行ファイル番号(配列@target_cmdsに対する添え字)
    # @param [String] target_dir テスト実行ディレクトリ（@test_dir_pnaからの相対パス）
    # @param [String] result_file 実行ファイルの実行結果を格納するファイルの名前
    # @param [Array] optionx （付加的な）コマンドラインオプション
    # @param [Array] param_names コマンドラインオプション群
    # @return [String] コマンドライン文字列
    def make_cmdline(cmd_index, target_dir, result_file, optionx, *param_names)
      make_cmdline_base(@target_cmds[cmd_index], target_dir, result_file, optionx, *param_names)
    end

    # 1番目の実行ファイル用コマンドライン作成
    # @param [String] target_dir テスト実行ディレクトリ（@test_dir_pnaからの相対パス）
    # @param [String] result_file 実行ファイルの実行結果を格納するファイルの名前　
    # @param [Array] optionx （付加的な）コマンドラインオプション
    # @param [Array] param_names コマンドラインオプション群
    # @return [String] コマンドライン文字列
    def make_cmdline_1(target_dir, result_file, optionx, *param_names)
      make_cmdline(0, target_dir, result_file, optionx, param_names)
    end

    # 2番目の実行ファイル用コマンドライン作成
    # @param [String] target_dir テスト実行ディレクトリ（@test_dir_pnaからの相対パス）
    # @param [String] result_file 実行ファイルの実行結果を格納するファイルの名前　
    # @param [Array] optionx （付加的な）コマンドラインオプション
    # @param [Array] param_names コマンドラインオプション群
    # @return [String] コマンドライン文字列
    def make_cmdline_2(target_dir, result_file, optionx, *param_names)
      make_cmdline(1, target_dir, result_file, optionx, param_names)
    end
  end
end
