# This is a subclass of Path that describes an attacking path. The main
# difference is that the scope of the piece includes the first blocking piece
class AttackingPath < Path
  def piece_scope
    return path if empty?

    path[0, blocking_piece_index + 1]
  end
end
