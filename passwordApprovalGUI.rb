require 'fox16'
#require './password_verification_test'
include Fox

class PasswordApproval < FXMainWindow

  def initialize(app)
    super(app, 'PasswordApproval', width: 400, height: 220)

    @passwordLabel = FXLabel.new(self, 'PASSWORD', opts: LAYOUT_CENTER_X)

    @passwordTextField = FXTextField.new(self, 50, opts: LAYOUT_CENTER_X)

    @uppercase_label = FXLabel.new(self, 'MUST HAVE ATLEAST ONE UPPERCASE LETTER', opts: LAYOUT_FIX_X | ICON_BEFORE_TEXT, x: 20)
    @uppercase_label.textColor = FXRGB(255, 0, 0)
    @lowercase_label = FXLabel.new(self, 'MUST HAVE ATLEAST ONE LOWERCASE LETTER', opts: LAYOUT_FIX_X, x: 20)
    @lowercase_label.textColor = FXRGB(255, 0, 0)
    @symbol_label = FXLabel.new(self, 'MUST HAVE ATLEAST ONE SPECIAL CHARACTER', opts: LAYOUT_FIX_X, x: 20)
    @symbol_label.textColor = FXRGB(255, 0, 0)
    @number_label = FXLabel.new(self, 'MUST HAVE ATLEAST ONE NUMBER', opts: LAYOUT_FIX_X, x: 20)
    @number_label.textColor = FXRGB(255, 0, 0)
    @length_label = FXLabel.new(self, 'MUST BE ATLEAST 8 CHARACTERS LONG ', opts: LAYOUT_FIX_X, x: 20)
    @length_label.textColor = FXRGB(255, 0, 0)
    @latin_label = FXLabel.new(self, 'MUST BE LATIN CHARACTERS ONLY ', opts: LAYOUT_FIX_X, x: 20)
    @latin_label.textColor = FXRGB(255, 0, 0)

    # OLD METHODS ----------------------------------
    # @passwordTextField.connect(SEL_VERIFY) do |sender, sel, tentative|
    #   if(tentative.length > 7)
    #     @length_label.textColor = FXRGB(0, 255, 0)
    #     false
    #   end
    #   if(tentative.length < 8)
    #     @length_label.textColor = FXRGB(255, 0, 0)
    #     false
    #   end
    #   # if tentative.length > 7
    #   #   @length_label.textColor = FXRGB(0, 255, 0)
    #   #   true
    #   # end
    #
    #   false
    # end
    # if tentative =~ /\p{Latin}/
    #   @latin_label.textColor = FXRGB(0, 255, 0)
    #   false
    # else
    # @latin_label.textColor = FXRGB(255, 0, 0)
    # false
    # end
    # END OF OLD METHODS ----------------------------------

    @passwordTextField.connect(SEL_CHANGED) do |sender, sel, tentative|
      puts tentative
      if (tentative =~ /^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$/)
        @latin_label.textColor = FXRGB(0, 255, 0)
        @number_label.textColor = FXRGB(0, 255, 0)
        @uppercase_label.textColor  = FXRGB(0, 255, 0)
        @lowercase_label.textColor = FXRGB(0, 255, 0)
        @symbol_label.textColor = FXRGB(0, 255, 0)
        @length_label.textColor  = FXRGB(0, 255, 0)

      else

        if tentative =~ /(?=.*[a-zA-Z])/
          @latin_label.textColor = FXRGB(0, 255, 0)
        else
          @latin_label.textColor = FXRGB(255, 0, 0)
        end
        if tentative =~ /[0-9]/
          @number_label.textColor = FXRGB(0, 255, 0)
        else
          @number_label.textColor = FXRGB(255, 0, 0)
        end
        if tentative =~ /[a-z]/
          @lowercase_label.textColor = FXRGB(0, 255, 0)
        else
          @lowercase_label.textColor = FXRGB(255, 0, 0)
        end
        if tentative =~ /[A-Z]/
          @uppercase_label.textColor = FXRGB(0, 255, 0)
        else
          @uppercase_label.textColor = FXRGB(255, 0, 0)
        end
        if tentative =~ /[[:punct:]]/ # ! @ # $ % ^ & * ( ) _ +
          @symbol_label.textColor = FXRGB(0, 255, 0)
        else
          @symbol_label.textColor = FXRGB(255, 0, 0)
        end
        if tentative.length > 7
          @length_label.textColor = FXRGB(0, 255, 0)
        else
          @length_label.textColor = FXRGB(255, 0, 0)
        end
        false
      end
    end
  end

  # OLD METHODS ----------------------------------
  # private def passwordValidation
  #   @password_verified = if @password =~ (/[A-Za-z0-9][[:punct:]][\p{Latin}]/) && @password.length > 7
  #                          true
  #                        else
  #                          false
  #
  #                        end
  # end
  #
  # private def verify_method
  #   if (!@password_verified)
  #     if @password =~ /\p{Latin}/
  #       @latin_label.textColor = FXRGB(0, 255, 0)
  #     elsif @password != ~/\p{Latin}/
  #       @latin_label.textColor = FXRGB(255, 0, 0)
  #     end

  #   unless @password =~ /[a-z]/
  #     puts "NEEDS ATLEAST ONE LOWERCASE LETTER [a - z]"
  #   end
  #   unless @password =~ /[A-Z]/
  #     puts "NEEDS ATLEAST ONE UPPERCASE LETTER [A - Z]"
  #   end
  #   unless @password =~ /[1-9]/
  #     puts "NEEDS ATLEAST ONE NUMBER [0 - 9]"
  #   end
  #   unless @password.length > 8
  #     puts "PASSWORD IS NOT LONG ENOUGH [MIN. OF 8 CHARACTERS]"
  #   end
  #   unless @password =~ /[[:punct:]]/
  #     puts "NEEDS ATLEAST ONE SPECIAL CHARACTER [SYMBOL]"
  #   end
  #   puts "ATTEMPTS LEFT #{@@attempt_counter}"
  #   @@attempt_counter -= 1
  #   if @@attempt_counter < 0
  #     abort "NO MORE ATTEMPTS LEFT"
  #   end

  # protected def label_color_change
  #   if @@password_text =~ /\p{Latin}/
  #     @latin_label.textColor = FXRGB(0, 255, 0)
  #   end
  #   # unless verify_method.password =~ /[a-z]/
  #   #   puts "NEEDS ATLEAST ONE LOWERCASE LETTER [a - z]"
  #   # end
  #   # unless verify_method.password =~ /[A-Z]/
  #   #   puts "NEEDS ATLEAST ONE UPPERCASE LETTER [A - Z]"
  #   # end
  #   # unless verify_method.password =~ /[1-9]/
  #   #   puts "NEEDS ATLEAST ONE NUMBER [0 - 9]"
  #   # end
  #   # unless verify_method.password.length > 8
  #   #   puts "PASSWORD IS NOT LONG ENOUGH [MIN. OF 8 CHARACTERS]"
  #   # end
  #   # unless verify_method.password =~ /[[:punct:]]/
  #   #   puts "NEEDS ATLEAST ONE SPECIAL CHARACTER [SYMBOL]"
  #   # end
  # end
  # END OF OLD METHODS ----------------------------------

  def create
    super
    show(PLACEMENT_SCREEN)
  end

end

if __FILE__ == $PROGRAM_NAME

  FXApp.new do |app|

    PasswordApproval.new(app)
    app.create
    app.run
  end
end
