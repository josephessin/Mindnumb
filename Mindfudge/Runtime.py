# Title: Runtime Library for Mindfudge
#
# Description: A very klunky implementation of the best-fit memory
# allocation/deallocation algorithm.
# Author: Joseph Essin
# Date: 11-11-2016

class Range:
    def __init__(self, location, length):
        self.location = location
        self.length = length

    def __str__(self):
        return "(" + str(self.location) + ", " + str(self.length) + ")"

# Freespace is an array of ranges
freespace = [Range(0, 30000)]

# Allocated is a dictionary of array names and their range
allocated = { }

"""
Return the address of an array allocated in memory.
"""
def address(arrayName):
    return allocated[arrayName].location

"""
Remove an allocated array from memory.
"""
def free(arrayName):
    # Find the range that is to become free space.
    range = allocated[arrayName]
    # Add the newly created free space back into the list of
    # free space ranges:
    freespace.append(range)
    # Remove the range from the dictionary of variables:
    del allocated[arrayName]
    # Combine adjacent free space ranges:
    combine()

"""
Loop through everything, combining adjacent ranges. O(n) time
"""
def combine():
    # Ensure the list is sorted by location:
    freespace.sort(key = lambda range: range.location)
    i = 0
    max = len(freespace) - 1
    while i < max:
        range1 = freespace[i]
        range2 = freespace[i + 1]
        if (range1.location + range1.length) == range2.location:
            range1.length += range2.length
            del freespace[i + 1]
            max = len(freespace) - 1
        else:
            i += 1


"""
Allocate space for an array in memory.
"""
def malloc(arrayName, size):
    # Search for free space that will hold the size.
    # Ensure that freespace is sorted by length before doing anything.
    freespace.sort(key = lambda range: range.length)
    # Find the first range big enough to hold our size:
    index = 0
    # O(n) time
    i = 0
    while i < len(freespace):
        range = freespace[i]
        if range.length >= size:
            # We found a spot of free space that is
            # big enough to hold the array we've requested.
            #
            # Go ahead and remove the range because we're going to fill
            # it up:
            del freespace[i]
            # See if the range is too big or
            if range.length == size:
                # The range is just big enough...remove it from the
                # list and put an entry of it in allocated
                allocated[arrayName] = range
            else:
                # The range is too big for the space we're allocating,
                # so we need to chop the remaining free space off and
                # put it into the array
                extra = range.length - size
                allocated[arrayName] = Range(range.location, size)
                freespace.append(Range(range.location + size, extra))
            # Now that we've allocated the memory, we need to leave:
            break
        i += 1
    # Combine adjacent free space ranges:
    combine()

"""
Converts a list to a string.
Credit: http://stackoverflow.com/a/5446232
"""
def strlist(list_or_iterator):
    return "[" + ", ".join( str(x) for x in list_or_iterator) + "]"
