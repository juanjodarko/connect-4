class CpuPlayer < Player

  def get_pos(range)
    sleep 1
    rand(range)
  end

  def end_phase(board)
  end

end
