/*
    Copyright (c) 2014 Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
 * @author Salesforce.org
 * @date 2014
 * @group Utilities
 * @description Class which holds static methods for common utilities,
 * such as detecting whether we are in a managed package, and some string helpers.
 */

public class UTIL_Namespace {
  /******************************************************************************************************
   * @description String helper property for getNamespace() method.
   *******************************************************************************************************/
  private static string plainNamespace;

  /******************************************************************************************************
   * @description Constant value for the npsp namespace, for use only when necessary in replacing hardcoded
   * namespace prefixes in field/object name strings Custom Settings/Custom Metadata.  This should not be
   * modified regardless of which namespace this code is being packaged in.
   *******************************************************************************************************/
  public static final String HARDCODED_NPSP_NAMESPACE = 'npsp';

  /***
   * @description Constant value for the Einstein enabled namespace, for checking if the org has
   * einstein insights platform has been installed or not.
   */
  private static final String EINSTEIN_INSIGHTS_NAMESPACE = 'OIQ';

  /*******************************************************************************************************
   * @description Finds the namespace for the current context.
   * @return string The current namespace as a string, or a blank string if we're not in a namespaced context.
   ********************************************************************************************************/
  public static string getNamespace() {
    if (plainNamespace == null) {
      string withDotNotation = UTIL_Namespace.class.getName();

      if (withDotNotation.contains('.')) {
        plainNamespace = withDotNotation.substringBefore('.');
      } else {
        plainNamespace = '';
      }
    }
    return plainNamespace;
  }

  /*******************************************************************************************************
   * @description Returns class name without the namespace (if any)
   */
  public static String removeClassNamespace(String className) {
    String classNameNoNamespace = className.substringAfter('.');

    return String.isBlank(classNameNoNamespace)
      ? className
      : classNameNoNamespace;
  }

  /*******************************************************************************************************
   * @description Static method adds the current namespace to a string if we're in a managed context,
   * with double underscore notation. If we're not in a managed context, returns the string itself.
   * @param str Token name.
   * @return Token name, with namespace prefix and double underscore if in a managed package.
   ********************************************************************************************************/
  public static string StrTokenNSPrefix(string str) {
    if (getNamespace() == '')
      return str;
    return getNamespace() + '__' + str;
  }

  /*******************************************************************************************************
   * @description Static method adds the current namespace to a string if we're in a managed context,
   * with dot notation. If we're not in a managed context, returns the string itself.
   * @param str Token name.
   * @return Token name, with namespace prefix and dot notation if in a managed package.
   ********************************************************************************************************/
  public static string StrTokenNSPrefixDotNotation(string str) {
    if (getNamespace() == '')
      return str;
    return getNamespace() + '.' + str;
  }

  /*******************************************************************************************************
   * @description If we are in a managed package, tokens in dynamic SOQL must include the package namespace
   * prefix, bit field describes don't include namespace prefix fields within the package. This method can
   * be used in our describe code to remove an incorrect namespace prefix.
   * Removes NPSP__ prefix, then removes dynamic prefix if one is detected.
   * @param str token name
   * @return token name, with namespace prefix removed, if present.
   ********************************************************************************************************/
  public static String StrTokenRemoveNSPrefix(String str) {
    if (str != null) {
      if (str.startsWith(HARDCODED_NPSP_NAMESPACE + '__')) {
        str = str.replaceFirst(HARDCODED_NPSP_NAMESPACE + '__', '');
      }

      if (getNamespace() != '' && str.startsWith(getNamespace() + '__')) {
        str = str.replaceFirst(getNamespace() + '__', '');
      }
    }

    return str;
  }

  /*******************************************************************************************************
   * @description Removes NPSP class prefix or dynamically removes current NS prefix.
   * @param str : the class name to have the namespace removed.
   * @return str : class name with namespace prefix removed.
   ********************************************************************************************************/
  public static String StrTokenRemoveClassNSPrefix(String str) {
    if (str != null) {
      if (str.startsWith(HARDCODED_NPSP_NAMESPACE + '.')) {
        str = str.replaceFirst(HARDCODED_NPSP_NAMESPACE + '.', '');
      }

      if (getNamespace() != '' && str.startsWith(getNamespace() + '.')) {
        str = str.replaceFirst(getNamespace() + '.', '');
      }
    }

    return str;
  }

  /*******************************************************************************************************
   * @description Static method that takes a string of a multiple potential field names or object names.
   * If it is a custom object or field (name ends with __c, __r, __mdt, or __e), it prepends the namespace prefix if required.
   * If we are in a managed package, tokens in dynamic SOQL must include the package namespace prefix.
   * If you ever deploy this package as unmanaged, this routine will do nothing!
   * @param str string that contains 0 or more token names
   * @return same string with token names, namespace prefixed, if required.
   ********************************************************************************************************/
  public static String StrAllNSPrefix(String str) {
    if (str == null || getNamespace() == '') {
      // There is no current package namespace, or the field is null
      return str;
    } else if (str.split('__').size() == 3) {
      // The field already has a namespace.
      return str;
    }

    Pattern pat = Pattern.Compile('[a-zA-z0-9]*__(?:c|r|mdt|e)');
    Matcher match = pat.matcher(str);
    return match.replaceAll(getNamespace() + '__$0');
  }
}
