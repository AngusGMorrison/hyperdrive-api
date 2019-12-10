module StorageCalculator

  def storage_used_in_bytes
    self.documents.sum { |document| document.byte_size }
  end

  def remaining_storage_in_bytes
    self.storage_allowance - self.storage_used_in_bytes
  end

  def has_enough_storage?(bytes)
    bytes <= self.remaining_storage_in_bytes
  end

end